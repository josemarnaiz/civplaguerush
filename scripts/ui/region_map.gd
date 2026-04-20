extends Control

signal region_clicked(region_id: String)
signal region_hovered(region_id: String)

const CONTROL_THRESHOLD: int = 60
const COL_COUNT: int = 4
const ROW_COUNT: int = 3
const VERT_COUNT: int = 11

# Ashen Fresco palette — see docs/ART_bible.md.
# Colors map to: D1 (background), D2 (shadow), B1 (ocean deep), R2 (rival),
# C1 (neutral stone), G2 (player olive), R4 (infection), O3 (gold signature).
const OCEAN_COLOR: Color = Color(0.122, 0.082, 0.125)          # D1 sepulcher (matches scene bg)
const OCEAN_GLOW: Color = Color(0.235, 0.290, 0.333, 0.45)     # B1 slate flecks
const LAND_RIVAL: Color = Color(0.478, 0.102, 0.141)           # R2 oxblood
const LAND_NEUTRAL: Color = Color(0.478, 0.396, 0.376)         # C1 aged stone
const LAND_PLAYER: Color = Color(0.420, 0.541, 0.235)          # G2 sickly olive (player power)
const INFECTION_COLOR: Color = Color(0.851, 0.329, 0.306)      # R4 wound red
const EDGE_COLOR: Color = Color(0.780, 0.604, 0.235, 0.55)     # O3 gold, dashed contagion
const BORDER_COLOR: Color = Color(0.059, 0.039, 0.055, 0.98)   # D0 outline
const RING_CONTROLLED: Color = Color(0.910, 0.753, 0.407, 1.0) # O4 gold highlight
const RING_SELECTABLE: Color = Color(0.969, 0.902, 0.659, 1.0) # O5 sheen
const RING_ACTIVE_TARGET: Color = Color(0.780, 0.604, 0.235, 1.0) # O3 signature
const RING_HOVER: Color = Color(0.910, 0.831, 0.706, 0.65)     # C4 cream glow
const RING_LOST: Color = Color(0.851, 0.329, 0.306, 0.95)      # R4 urgent loss flash
const SHADOW_COLOR: Color = Color(0.059, 0.039, 0.055, 0.55)   # D0 soft shadow
const STAR_COLOR: Color = Color(0.969, 0.902, 0.659, 0.95)     # O5 sheen star
const TOOLTIP_BG: Color = Color(0.122, 0.082, 0.125, 0.96)     # D1 deep
const TOOLTIP_BORDER: Color = Color(0.780, 0.604, 0.235, 1.0)  # O3 gold
const TOOLTIP_TITLE: Color = Color(0.969, 0.902, 0.659, 1.0)   # O5 sheen
const TOOLTIP_TEXT: Color = Color(0.910, 0.831, 0.706, 1.0)    # C4 cream

const TWEEN_SPEED: float = 6.5          # higher = snappier approach of display values
const TOOLTIP_DELAY: float = 0.35       # seconds hovering before tooltip shows
const BIOME_ICON_SIZE: float = 22.0     # drawn size of biome icon above region label

# Region id -> biome archetype. Texture path is assets/art/map/biome_<arch>.png.
# Keep in sync with tools/art_gen/gen_biomes.py.
const BIOME_BY_REGION: Dictionary = {
	"r01": "arcology",  "r02": "coast",     "r03": "wasteland",
	"r04": "tundra",    "r05": "factory",   "r06": "tech",
	"r07": "ruins",     "r08": "veil",      "r09": "drylands",
	"r10": "islands",   "r11": "jungle",    "r12": "volcano",
}

const BIOME_TEXTURE_PATHS: Dictionary = {
	"arcology": "res://assets/art/map/biome_arcology.png",
	"coast": "res://assets/art/map/biome_coast.png",
	"wasteland": "res://assets/art/map/biome_wasteland.png",
	"tundra": "res://assets/art/map/biome_tundra.png",
	"factory": "res://assets/art/map/biome_factory.png",
	"tech": "res://assets/art/map/biome_tech.png",
	"ruins": "res://assets/art/map/biome_ruins.png",
	"veil": "res://assets/art/map/biome_veil.png",
	"drylands": "res://assets/art/map/biome_drylands.png",
	"islands": "res://assets/art/map/biome_islands.png",
	"jungle": "res://assets/art/map/biome_jungle.png",
	"volcano": "res://assets/art/map/biome_volcano.png",
}
const INFECTION_TEX_PATH: String = "res://assets/art/map/infection_noise.png"
const PLAGUE_SIGIL_PATH: String = "res://assets/art/map/plague_sigil.png"
const INFECTION_TILE_SIZE: float = 32.0

var _snapshot: Array = []
var _polygons: Dictionary = {}        # id -> Array[PackedVector2Array] (normalized 0..1)
var _centroids: Dictionary = {}       # id -> Vector2 normalized
var _adjacency_edges: Array = []      # [[Vector2, Vector2, "direction_label"], ...]
var _selectable_ids: Dictionary = {}
var _selection_active: bool = false
var _active_target_id: String = ""
var _hover_id: String = ""
var _hover_since: float = -1.0
var _last_mouse_pos: Vector2 = Vector2.ZERO
var _display_values: Dictionary = {}  # id -> {influence: float, infection: float}
var _lost_flash_until: Dictionary = {} # id -> time seconds
var _biome_textures: Dictionary = {}   # biome id -> Texture2D
var _infection_tex: Texture2D = null
var _plague_sigil: Texture2D = null
var _time: float = 0.0


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	# Required so draw_polygon with UVs > 1 actually tiles the infection texture.
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	_load_optional_textures()
	set_process(true)


func _process(delta: float) -> void:
	_time += delta
	_update_display_values(delta)
	if not _snapshot.is_empty():
		queue_redraw()


func _update_display_values(delta: float) -> void:
	if _snapshot.is_empty():
		return
	var k: float = clampf(delta * TWEEN_SPEED, 0.0, 1.0)
	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		var target_infl: float = float(int(r.get("influence", 0)))
		var target_inf: float = float(int(r.get("infection", 0)))
		if not _display_values.has(id):
			_display_values[id] = { "influence": target_infl, "infection": target_inf }
			continue
		var d: Dictionary = _display_values[id]
		d["influence"] = lerp(float(d["influence"]), target_infl, k)
		d["infection"] = lerp(float(d["infection"]), target_inf, k)
		_display_values[id] = d


func _display_for(id: String, key: String, fallback: float) -> float:
	if _display_values.has(id):
		return float(_display_values[id].get(key, fallback))
	return fallback


func build_from_snapshot(snapshot: Array) -> void:
	_snapshot = snapshot.duplicate(true)
	_generate_polygons()
	_build_adjacency_edges()
	queue_redraw()


func refresh(snapshot: Array) -> void:
	if _snapshot.is_empty() or _polygons.is_empty():
		build_from_snapshot(snapshot)
		return
	_snapshot = snapshot.duplicate(true)
	queue_redraw()


func set_selectable(ids: Array) -> void:
	_selectable_ids.clear()
	for id in ids:
		_selectable_ids[String(id)] = true
	_selection_active = true
	queue_redraw()


func clear_selectable() -> void:
	_selectable_ids.clear()
	_selection_active = false
	queue_redraw()


# Marks the region that the current regional event acts on, so the map
# pulses it in gold to visually tie the event text ("Outbreak in X") to
# its target on the grid.
func set_active_target(region_id: String) -> void:
	_active_target_id = String(region_id)
	queue_redraw()


func clear_active_target() -> void:
	_active_target_id = ""
	queue_redraw()


func flash_region_loss(region_id: String, duration: float = 1.2) -> void:
	if region_id.is_empty():
		return
	_lost_flash_until[region_id] = _time + max(duration, 0.2)
	queue_redraw()


# --- Geometry --------------------------------------------------------------

func _generate_polygons() -> void:
	_polygons.clear()
	_centroids.clear()
	# Keep landmass inside the view with a small ocean margin around the edges.
	var pad_x: float = 0.055
	var pad_y: float = 0.07
	var col_w: float = (1.0 - 2.0 * pad_x) / float(COL_COUNT)
	var row_h: float = (1.0 - 2.0 * pad_y) / float(ROW_COUNT)

	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		var grid: Array = r.get("grid", [0, 0])
		var col: int = int(grid[0])
		var row: int = int(grid[1])

		var rng := RandomNumberGenerator.new()
		rng.seed = hash(id)

		var cx: float = pad_x + (float(col) + 0.5) * col_w + rng.randf_range(-0.015, 0.015)
		var cy: float = pad_y + (float(row) + 0.5) * row_h + rng.randf_range(-0.018, 0.018)
		_centroids[id] = Vector2(cx, cy)

		var aspect_jitter: float = rng.randf_range(0.85, 1.18)
		var base_rx: float = col_w * 0.52 * aspect_jitter
		var base_ry: float = row_h * 0.54 / aspect_jitter

		var shapes: Array = []
		if id == "r10":
			# Sunken Archipelago: three small islands widely separated.
			var offs: Array = [
				[Vector2(-0.075, -0.038), 0.36],
				[Vector2( 0.070, -0.010), 0.30],
				[Vector2( 0.015,  0.065), 0.34]
			]
			for o in offs:
				var off: Vector2 = o[0]
				var island_scale: float = o[1]
				shapes.append(_organic_blob(Vector2(cx + off.x, cy + off.y), base_rx * island_scale, base_ry * island_scale, rng, 8))
		else:
			shapes.append(_organic_blob(Vector2(cx, cy), base_rx, base_ry, rng, VERT_COUNT))
		_polygons[id] = shapes


func _organic_blob(center: Vector2, rx: float, ry: float, rng: RandomNumberGenerator, verts: int) -> PackedVector2Array:
	var poly := PackedVector2Array()
	var phase: float = rng.randf() * TAU
	var phase2: float = rng.randf() * TAU
	for i in range(verts):
		var ang: float = TAU * float(i) / float(verts) + rng.randf_range(-0.06, 0.06)
		# Organic lobes via layered sines + random per-vertex jitter.
		var lobe: float = (
			sin(ang * 3.0 + phase) * 0.16
			+ sin(ang * 5.0 + phase2) * 0.09
			+ sin(ang * 7.0 + phase * 1.7) * 0.05
		)
		var noise: float = rng.randf_range(-0.10, 0.10)
		var r: float = 1.0 + lobe + noise
		poly.append(center + Vector2(cos(ang) * rx * r, sin(ang) * ry * r))
	return poly


func _build_adjacency_edges() -> void:
	_adjacency_edges.clear()
	var seen: Dictionary = {}
	for r in _snapshot:
		var a: String = String(r.get("id", ""))
		for n in r.get("neighbors", []):
			var b: String = String(n)
			var key: String = (a + "|" + b) if a < b else (b + "|" + a)
			if seen.has(key):
				continue
			seen[key] = true
			if _centroids.has(a) and _centroids.has(b):
				_adjacency_edges.append([_centroids[a], _centroids[b]])


# --- Rendering -------------------------------------------------------------

func _draw() -> void:
	var s: Vector2 = size
	if s.x <= 0.0 or s.y <= 0.0:
		return

	# Ocean background with soft radial vignette.
	draw_rect(Rect2(Vector2.ZERO, s), OCEAN_COLOR)
	_draw_ocean_flecks(s)

	# Adjacency edges drawn behind land, dashed so they read as contagion routes in the water.
	for e in _adjacency_edges:
		var a: Vector2 = e[0] * s
		var b: Vector2 = e[1] * s
		_draw_dashed_line(a, b, EDGE_COLOR, 1.3, 6.0, 4.0)

	# Pass 1: shadows.
	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		if not _polygons.has(id):
			continue
		for poly_norm in _polygons[id]:
			var shadow := PackedVector2Array()
			for v in poly_norm:
				shadow.append(v * s + Vector2(2.0, 3.5))
			draw_colored_polygon(shadow, SHADOW_COLOR)

	# Pass 2: land fill + infection overlay + borders + rings.
	# Colors use tweened display values so transitions are smooth; rings still
	# key off the logical snapshot so e.g. a newly-controlled region gets its
	# ring immediately without waiting for the lerp to converge.
	var target_pulse: float = (sin(_time * 2.8) + 1.0) * 0.5   # 0..1
	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		if not _polygons.has(id):
			continue
		var influence: int = int(r.get("influence", 0))
		var display_infl: float = _display_for(id, "influence", float(influence))
		var display_inf: float = _display_for(id, "infection", float(int(r.get("infection", 0))))
		var fill: Color = _influence_color(display_infl)
		var inf_alpha: float = clampf(display_inf / 100.0 * 0.72, 0.0, 0.72)
		var border_w: float = 1.6
		var ring_color: Color = Color(0, 0, 0, 0)
		var ring_w: float = 0.0

		if _selection_active and _selectable_ids.has(id):
			ring_color = RING_SELECTABLE
			ring_w = 2.6
		elif influence >= CONTROL_THRESHOLD:
			ring_color = RING_CONTROLLED
			ring_w = 2.0

		for poly_norm in _polygons[id]:
			var poly := PackedVector2Array()
			for v in poly_norm:
				poly.append(v * s)

			draw_colored_polygon(poly, fill)
			if inf_alpha > 0.02:
				if _infection_tex != null:
					# Textured infection overlay: tiled noise in world space, tinted
					# toward red as infection rises. UVs = poly / tile_size produces
					# seamless tiling regardless of polygon shape.
					var uvs := PackedVector2Array()
					for p in poly:
						uvs.append(p / INFECTION_TILE_SIZE)
					var cols := PackedColorArray()
					var tint: Color = INFECTION_COLOR
					tint.a = clampf(inf_alpha * 1.35, 0.0, 0.92)
					for i in range(poly.size()):
						cols.append(tint)
					draw_polygon(poly, cols, uvs, _infection_tex)
				else:
					var flat: Color = INFECTION_COLOR
					flat.a = clampf(inf_alpha, 0.0, 0.72)
					draw_colored_polygon(poly, flat)

			var closed := PackedVector2Array(poly)
			closed.append(poly[0])
			draw_polyline(closed, BORDER_COLOR, border_w, true)
			if ring_color.a > 0.0:
				draw_polyline(closed, ring_color, ring_w, true)
			if _active_target_id == id:
				var target_col: Color = RING_ACTIVE_TARGET
				target_col.a = 0.55 + target_pulse * 0.45
				var target_w: float = 2.4 + target_pulse * 2.6
				draw_polyline(closed, target_col, target_w, true)
			if _lost_flash_until.has(id):
				var until: float = float(_lost_flash_until[id])
				if _time <= until:
					var remain: float = clampf((until - _time) / 1.2, 0.0, 1.0)
					var loss_col: Color = RING_LOST
					loss_col.a = 0.25 + remain * 0.75
					draw_polyline(closed, loss_col, 3.2 + (1.0 - remain) * 1.4, true)
				else:
					_lost_flash_until.erase(id)
			if _hover_id == id:
				draw_polyline(closed, RING_HOVER, 1.2, true)

	# Pass 3a: biome icons (stacked above labels).
	for r in _snapshot:
		var bid: String = String(r.get("id", ""))
		if not _centroids.has(bid):
			continue
		var biome: String = String(BIOME_BY_REGION.get(bid, ""))
		if biome == "" or not _biome_textures.has(biome):
			continue
		var tex: Texture2D = _biome_textures[biome]
		var bc: Vector2 = _centroids[bid] * s
		var rect := Rect2(bc + Vector2(-BIOME_ICON_SIZE * 0.5, -BIOME_ICON_SIZE - 2.0),
			Vector2(BIOME_ICON_SIZE, BIOME_ICON_SIZE))
		# Slight cream tint when heavily infected, so biomes "rot" visually.
		var display_inf_biome: float = _display_for(bid, "infection", float(int(r.get("infection", 0))))
		var tint: Color = Color(1, 1, 1, 1)
		if display_inf_biome > 40.0:
			var t: float = clampf((display_inf_biome - 40.0) / 60.0, 0.0, 1.0)
			tint = Color(1, 1, 1, 1).lerp(Color(1.0, 0.55, 0.45, 1.0), t)
		draw_texture_rect(tex, rect, false, tint)

	# Pass 3b: labels (under icon).
	var font: Font = get_theme_default_font()
	if font != null:
		var name_size: int = 13
		var stats_size: int = 11
		for r in _snapshot:
			var id: String = String(r.get("id", ""))
			if not _centroids.has(id):
				continue
			var c: Vector2 = _centroids[id] * s
			var short_name: String = String(r.get("short", id))
			var stats_text: String = "I:%d V:%d" % [int(r.get("influence", 0)), int(r.get("infection", 0))]
			var ns: Vector2 = font.get_string_size(short_name, HORIZONTAL_ALIGNMENT_LEFT, -1, name_size)
			var ss: Vector2 = font.get_string_size(stats_text, HORIZONTAL_ALIGNMENT_LEFT, -1, stats_size)
			# Name sits just below the biome icon; stats under the name.
			var name_pos: Vector2 = Vector2(c.x - ns.x / 2.0, c.y + 12.0)
			var stats_pos: Vector2 = Vector2(c.x - ss.x / 2.0, c.y + 24.0)
			draw_string(font, name_pos + Vector2(1, 1), short_name,
				HORIZONTAL_ALIGNMENT_LEFT, -1, name_size, Color(0, 0, 0, 0.75))
			draw_string(font, name_pos, short_name,
				HORIZONTAL_ALIGNMENT_LEFT, -1, name_size, TOOLTIP_TITLE)
			draw_string(font, stats_pos + Vector2(1, 1), stats_text,
				HORIZONTAL_ALIGNMENT_LEFT, -1, stats_size, Color(0, 0, 0, 0.6))
			draw_string(font, stats_pos, stats_text,
				HORIZONTAL_ALIGNMENT_LEFT, -1, stats_size, TOOLTIP_TEXT)

	# Pass 4: plague sigil on the most-infected region (the outbreak focus).
	# A pulsing halo behind the sigil reads as a warning beacon.
	var worst_id: String = _most_infected_id(40)
	if worst_id != "" and _centroids.has(worst_id):
		var wc: Vector2 = _centroids[worst_id] * s
		var t: float = (sin(_time * 3.5) + 1.0) * 0.5  # 0..1
		var halo: Color = INFECTION_COLOR
		halo.a = 0.20 + 0.35 * (1.0 - t)
		draw_circle(wc, 14.0 + t * 6.0, halo)
		if _plague_sigil != null:
			# Draw sigil centered, slightly scaled by pulse for the "beat" feel.
			var sz_base: float = 20.0
			var sz_s: float = sz_base + t * 3.0
			var rect := Rect2(wc - Vector2(sz_s * 0.5, sz_s * 0.5),
				Vector2(sz_s, sz_s))
			var sig_tint: Color = Color(1, 1, 1, 0.75 + 0.25 * t)
			draw_texture_rect(_plague_sigil, rect, false, sig_tint)
		else:
			draw_circle(wc, 4.0, Color(1.0, 0.7, 0.7, 0.9))

	# Pass 5: capital star on each player-controlled region (upper-right of biome icon).
	for r in _snapshot:
		if int(r.get("influence", 0)) < CONTROL_THRESHOLD:
			continue
		var id: String = String(r.get("id", ""))
		if not _centroids.has(id):
			continue
		var c: Vector2 = _centroids[id] * s + Vector2(BIOME_ICON_SIZE * 0.5 + 2.0, -BIOME_ICON_SIZE - 2.0)
		# Backing disc for contrast, then gold star.
		draw_circle(c, 5.0, Color(0.059, 0.039, 0.055, 0.85))
		_draw_star(c, 4.2, STAR_COLOR)

	# Pass 6: tooltip for the hovered region (after a short delay).
	_draw_hover_tooltip(s)


func _draw_hover_tooltip(s: Vector2) -> void:
	if _hover_id == "":
		return
	if _hover_since < 0.0 or _time - _hover_since < TOOLTIP_DELAY:
		return
	var region: Dictionary = {}
	for r in _snapshot:
		if String(r.get("id", "")) == _hover_id:
			region = r
			break
	if region.is_empty():
		return
	var font: Font = get_theme_default_font()
	if font == null:
		return

	var title: String = String(region.get("name", ""))
	var stats: String = "Influence %d    Infection %d    Stability %d" % [
		int(region.get("influence", 0)),
		int(region.get("infection", 0)),
		int(region.get("stability", 0))
	]
	var neighbors: Array = region.get("neighbors", [])
	var neighbors_line: String = "Neighbors: %d" % neighbors.size()

	var title_size: int = 14
	var text_size: int = 11
	var ts: Vector2 = font.get_string_size(title, HORIZONTAL_ALIGNMENT_LEFT, -1, title_size)
	var ss: Vector2 = font.get_string_size(stats, HORIZONTAL_ALIGNMENT_LEFT, -1, text_size)
	var ns: Vector2 = font.get_string_size(neighbors_line, HORIZONTAL_ALIGNMENT_LEFT, -1, text_size)

	var pad_x: float = 10.0
	var pad_y: float = 8.0
	var line_gap: float = 4.0
	var w: float = max(ts.x, max(ss.x, ns.x)) + pad_x * 2.0
	var h: float = ts.y + ss.y + ns.y + line_gap * 2.0 + pad_y * 2.0

	var pos: Vector2 = _last_mouse_pos + Vector2(14.0, -10.0)
	if pos.x + w > s.x:
		pos.x = _last_mouse_pos.x - w - 14.0
	if pos.y + h > s.y:
		pos.y = s.y - h - 2.0
	if pos.x < 0.0:
		pos.x = 0.0
	if pos.y < 0.0:
		pos.y = 0.0

	var rect := Rect2(pos, Vector2(w, h))
	draw_rect(rect, TOOLTIP_BG)
	draw_rect(rect, TOOLTIP_BORDER, false, 1.2)

	var cursor: Vector2 = pos + Vector2(pad_x, pad_y + ts.y - 2.0)
	draw_string(font, cursor, title, HORIZONTAL_ALIGNMENT_LEFT, -1, title_size, TOOLTIP_TITLE)
	cursor.y += ss.y + line_gap
	draw_string(font, cursor, stats, HORIZONTAL_ALIGNMENT_LEFT, -1, text_size, TOOLTIP_TEXT)
	cursor.y += ns.y + line_gap
	draw_string(font, cursor, neighbors_line, HORIZONTAL_ALIGNMENT_LEFT, -1, text_size, TOOLTIP_TEXT)


func _draw_dashed_line(a: Vector2, b: Vector2, color: Color, width: float, dash: float, gap: float) -> void:
	var total: float = a.distance_to(b)
	if total <= 0.001:
		return
	var dir: Vector2 = (b - a) / total
	var step: float = dash + gap
	var t: float = 0.0
	while t < total:
		var p1: Vector2 = a + dir * t
		var p2: Vector2 = a + dir * min(t + dash, total)
		draw_line(p1, p2, color, width, true)
		t += step


func _draw_ocean_flecks(s: Vector2) -> void:
	# Subtle constant-pattern noise: deterministic dots so it doesn't flicker.
	var rng := RandomNumberGenerator.new()
	rng.seed = 0xC1A7E
	for _i in range(36):
		var p: Vector2 = Vector2(rng.randf() * s.x, rng.randf() * s.y)
		var rad: float = rng.randf_range(0.6, 1.4)
		draw_circle(p, rad, OCEAN_GLOW)


func _draw_star(center: Vector2, r: float, color: Color) -> void:
	var pts := PackedVector2Array()
	for i in range(10):
		var ang: float = -PI / 2.0 + TAU * float(i) / 10.0
		var radius: float = r if (i % 2 == 0) else r * 0.45
		pts.append(center + Vector2(cos(ang) * radius, sin(ang) * radius))
	draw_colored_polygon(pts, color)


func _load_optional_textures() -> void:
	_biome_textures.clear()
	for key in BIOME_TEXTURE_PATHS.keys():
		var tex: Texture2D = _safe_load_texture(String(BIOME_TEXTURE_PATHS[key]))
		if tex != null:
			_biome_textures[String(key)] = tex
	_infection_tex = _safe_load_texture(INFECTION_TEX_PATH)
	_plague_sigil = _safe_load_texture(PLAGUE_SIGIL_PATH)


func _safe_load_texture(path: String) -> Texture2D:
	if not ResourceLoader.exists(path):
		return null
	var res: Resource = ResourceLoader.load(path)
	if res is Texture2D:
		return res as Texture2D
	return null


func _most_infected_id(min_infection: int) -> String:
	var worst: int = min_infection - 1
	var worst_id: String = ""
	for r in _snapshot:
		var inf: int = int(r.get("infection", 0))
		if inf > worst:
			worst = inf
			worst_id = String(r.get("id", ""))
	return worst_id


func _influence_color(influence: float) -> Color:
	var f: float = clampf(influence / 100.0, 0.0, 1.0)
	if f <= 0.2:
		var t: float = f / 0.2
		return LAND_RIVAL.lerp(LAND_NEUTRAL, t)
	var t2: float = (f - 0.2) / 0.8
	return LAND_NEUTRAL.lerp(LAND_PLAYER, t2)


# --- Input -----------------------------------------------------------------

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_handle_hover((event as InputEventMouseMotion).position)
	elif event is InputEventMouseButton:
		var mb: InputEventMouseButton = event
		if mb.pressed and mb.button_index == MOUSE_BUTTON_LEFT:
			_handle_click(mb.position)
	elif event is InputEventScreenTouch:
		var st: InputEventScreenTouch = event
		if st.pressed:
			_handle_click(st.position)


func _handle_hover(pos: Vector2) -> void:
	_last_mouse_pos = pos
	var id: String = _region_at(pos)
	if id != _hover_id:
		_hover_id = id
		_hover_since = _time
		if id != "":
			emit_signal("region_hovered", id)
		queue_redraw()


func _handle_click(pos: Vector2) -> void:
	var id: String = _region_at(pos)
	if id == "":
		return
	if _selection_active and not _selectable_ids.has(id):
		return
	emit_signal("region_clicked", id)


func _region_at(pos: Vector2) -> String:
	var s: Vector2 = size
	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		if not _polygons.has(id):
			continue
		for poly_norm in _polygons[id]:
			var poly := PackedVector2Array()
			for v in poly_norm:
				poly.append(v * s)
			if Geometry2D.is_point_in_polygon(pos, poly):
				return id
	return ""
