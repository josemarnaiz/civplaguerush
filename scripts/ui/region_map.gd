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
const OCEAN_DEEP: Color = Color(0.082, 0.059, 0.094)           # darker than D1, abyss
const OCEAN_COLOR: Color = Color(0.122, 0.082, 0.125)          # D1 sepulcher (matches scene bg)
const OCEAN_SHELF: Color = Color(0.165, 0.133, 0.176)           # continental shelf halo
const OCEAN_GLOW: Color = Color(0.235, 0.290, 0.333, 0.45)     # B1 slate flecks
const OCEAN_WAVE: Color = Color(0.780, 0.604, 0.235, 0.16)     # O3 gold, faint current lines
const LATITUDE_COLOR: Color = Color(0.780, 0.604, 0.235, 0.10) # O3 dotted latitude lines
const CLOUD_COLOR: Color = Color(0.910, 0.831, 0.706, 0.08)    # C4 drifting cloud shadows
const COAST_COLOR: Color = Color(0.059, 0.039, 0.055, 0.98)    # D0 dark shoreline stroke
const COAST_GLOW: Color = Color(0.910, 0.831, 0.706, 0.35)     # C4 faint beach rim
const INTERNAL_BORDER: Color = Color(0.780, 0.604, 0.235, 0.70) # O3 gold dashed political border
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
const PLAGUE_TENDRIL_THRESHOLD: float = 50.0  # infection% at which tendrils appear
const PLAGUE_TENDRIL_COLOR: Color = Color(0.851, 0.329, 0.306, 1.0)  # R4
const PLAGUE_TENDRIL_CORE: Color = Color(0.698, 0.165, 0.204, 1.0)   # R3

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
const COMPASS_ROSE_PATH: String = "res://assets/art/map/compass_rose.png"
const INFECTION_TILE_SIZE: float = 32.0
const COMPASS_SIZE: float = 56.0

# Continent layout: each entry is [row_index, [col_group_a, col_group_b, ...]].
# Every col_group is a list of column indices that share a landmass; between
# groups there is open sea. This converts the 4x3 grid of regions into an
# Earth-like arrangement of three latitudinal continents with inner seas.
const CONTINENT_LAYOUT: Array = [
	[0, [[0, 1, 2, 3]]],          # Northern continent: full-width (Eurasia-like)
	[1, [[0, 1], [2, 3]]],        # Equatorial: Western Reach + Eastern Marches with Atlantic-like gap
	[2, [[0], [1], [2, 3]]],      # Southern: Drylands island, Archipelago, Equator-Peaks continent
]
const COAST_SAMPLES_PER_COL: int = 12
const COAST_AMPLITUDE: float = 0.022
const SIDE_COAST_INDENT: float = 0.014

var _snapshot: Array = []
var _polygons: Dictionary = {}        # id -> Array[PackedVector2Array] (normalized 0..1)
var _centroids: Dictionary = {}       # id -> Vector2 normalized
var _adjacency_edges: Array = []      # [[Vector2, Vector2], ...] normalized
# Per-continent exterior coastlines (ordered loop of points in normalized 0..1).
# Drawn as thick dark polylines on top of region fills to unify the landmass.
var _continent_exteriors: Array = []  # Array[PackedVector2Array]
# Internal political borders between adjacent regions in the same continent.
# Each entry: PackedVector2Array of 2+ points to draw as a gold dashed segment.
var _continent_internal_borders: Array = []
# Decorative non-interactive islets scattered in the seas between continents.
# Each entry is a PackedVector2Array in normalized 0..1 coordinates.
var _ocean_islets: Array = []
var _turn_flash_until: float = -1.0   # while _time < this, a gold flash fades over the map
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
var _compass_rose: Texture2D = null
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


# Triggers a decorative gold flash over the map that fades out over 0.6s.
# Call this when the turn rolls over so the player gets a clear visual beat.
func trigger_turn_flash(duration: float = 0.6) -> void:
	_turn_flash_until = _time + max(0.1, duration)
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
	_continent_exteriors.clear()
	_continent_internal_borders.clear()
	_ocean_islets.clear()

	# Build a lookup: (col, row) -> region_id, so we can map grid cells to data.
	var grid_to_id: Dictionary = {}
	for r in _snapshot:
		var grid: Array = r.get("grid", [0, 0])
		grid_to_id[Vector2i(int(grid[0]), int(grid[1]))] = String(r.get("id", ""))

	var pad_x: float = 0.055
	var pad_y: float = 0.08
	var col_w: float = (1.0 - 2.0 * pad_x) / float(COL_COUNT)
	var row_h: float = (1.0 - 2.0 * pad_y) / float(ROW_COUNT)

	for layout in CONTINENT_LAYOUT:
		var row: int = int(layout[0])
		var groups: Array = layout[1]
		for group in groups:
			var ids: Array = []
			for col in group:
				var key := Vector2i(int(col), row)
				ids.append(String(grid_to_id.get(key, "")))
			# Skip groups that have no matching regions in the snapshot.
			var has_any: bool = false
			for gid in ids:
				if String(gid) != "":
					has_any = true
					break
			if not has_any:
				continue

			var y_top: float = pad_y + float(row) * row_h + 0.012
			var y_bot: float = pad_y + float(row + 1) * row_h - 0.012
			var x_left: float = pad_x + float(int(group[0])) * col_w + 0.006
			var x_right: float = pad_x + float(int(group[-1]) + 1) * col_w - 0.006

			if row == 2 and group.size() == 1 and int(group[0]) == 1:
				# Sunken Archipelago -> 3 small islands inside the sea gap.
				_build_archipelago(String(ids[0]), x_left, x_right, y_top, y_bot)
			else:
				_build_continent(ids, group, row, x_left, x_right, y_top, y_bot)

	_generate_ocean_islets()


func _build_continent(ids: Array, cols: Array, row: int,
		x_left: float, x_right: float, y_top: float, y_bot: float) -> void:
	var n_cols: int = ids.size()
	var samples: int = n_cols * COAST_SAMPLES_PER_COL
	var rng := RandomNumberGenerator.new()
	rng.seed = hash("cont_%d_%d_%d" % [row, int(cols[0]), int(cols[-1])])

	# Coast phase offsets so each continent has a unique shoreline signature.
	var ph_tL: float = rng.randf() * TAU    # long (continental) wave
	var ph_tM: float = rng.randf() * TAU    # medium coastline
	var ph_tS: float = rng.randf() * TAU    # fine detail
	var ph_bL: float = rng.randf() * TAU
	var ph_bM: float = rng.randf() * TAU
	var ph_bS: float = rng.randf() * TAU

	# Latitude-dependent amplitude: arctic continents have jaggier shorelines;
	# tropical bulge downward. Also scale long-wave amplitude by group width so
	# wider continents can have bigger continental curves.
	var group_width: float = x_right - x_left
	var amp_long: float = clampf(group_width * 0.09, 0.018, 0.055)
	var amp_medium: float = 0.014
	var amp_small: float = 0.006
	if row == 0:
		amp_medium *= 1.20
		amp_small *= 1.25
	elif row == 2:
		amp_long *= 1.10

	# Continental axis curve: a single slow sine shared by top and bottom
	# shifts the whole continent up or down along its length, so the landmass
	# actually bends instead of looking like a horizontal brick. Phase offsets
	# are per-continent so each has a distinct shape.
	var axis_phase: float = rng.randf() * TAU
	var axis_amp: float = clampf(group_width * 0.08, 0.010, 0.040)

	# ---- Build top & bottom wavy coastlines as two parallel arrays --------
	var top_coast: PackedVector2Array = PackedVector2Array()
	var bot_coast: PackedVector2Array = PackedVector2Array()
	for i in range(samples + 1):
		var t: float = float(i) / float(samples)
		var x: float = lerpf(x_left, x_right, t)
		# Taper the outer 12% so the coast meets the side coast smoothly; the
		# interior keeps the full amplitude for a natural continental outline.
		var edge_taper: float = smoothstep(0.0, 0.12, t) * smoothstep(0.0, 0.12, 1.0 - t)
		# Shared bend of the continent's vertical axis (positive = lower).
		var axis_shift: float = sin(t * PI * 1.0 + axis_phase) * axis_amp * 0.55 \
				+ sin(t * PI * 2.0 + axis_phase * 1.7) * axis_amp * 0.20
		# Independent wavy coastlines (top lifts, bottom drops).
		var long_t: float = sin(t * TAU * 0.75 + ph_tL) * amp_long
		var long_b: float = sin(t * TAU * 0.70 + ph_bL + 1.3) * amp_long * 0.9
		var dy_top: float = (
				long_t
				+ sin(t * TAU * 2.2 + ph_tM) * amp_medium
				+ sin(t * TAU * 4.7 + ph_tS) * amp_small
			) * edge_taper
		var dy_bot: float = (
				long_b
				+ sin(t * TAU * 2.0 + ph_bM) * amp_medium
				+ sin(t * TAU * 4.1 + ph_bS) * amp_small
			) * edge_taper
		top_coast.append(Vector2(x, y_top + axis_shift - dy_top))
		bot_coast.append(Vector2(x, y_bot + axis_shift + dy_bot))

	# ---- West and East side coasts (curvy vertical segments) --------------
	var west_coast: PackedVector2Array = PackedVector2Array()
	var east_coast: PackedVector2Array = PackedVector2Array()
	var side_steps: int = 6
	for i in range(1, side_steps):
		var tv: float = float(i) / float(side_steps)
		var y_west: float = lerpf(top_coast[0].y, bot_coast[0].y, tv)
		var y_east: float = lerpf(top_coast[-1].y, bot_coast[-1].y, tv)
		var dx_w: float = sin(tv * PI * 1.5 + ph_tL) * SIDE_COAST_INDENT * rng.randf_range(0.6, 1.3)
		var dx_e: float = sin(tv * PI * 1.5 + ph_bL) * SIDE_COAST_INDENT * rng.randf_range(0.6, 1.3)
		west_coast.append(Vector2(x_left - abs(dx_w), y_west))   # bulge outward left
		east_coast.append(Vector2(x_right + abs(dx_e), y_east))  # bulge outward right

	# ---- Build one polygon per region using shared boundary points --------
	for i in range(n_cols):
		var id: String = String(ids[i])
		if id == "":
			continue
		var j0: int = i * COAST_SAMPLES_PER_COL
		var j1: int = (i + 1) * COAST_SAMPLES_PER_COL

		var poly: PackedVector2Array = PackedVector2Array()

		# Top edge (left -> right)
		for j in range(j0, j1 + 1):
			poly.append(top_coast[j])

		# Right side
		if i == n_cols - 1:
			# Exterior east coast (runs top -> bottom)
			for p in east_coast:
				poly.append(p)
		else:
			# Shared internal boundary with the next region: slightly jittered
			# vertical line so it doesn't look like a ruler. Jitter is seeded
			# from the boundary position to stay stable across frames.
			var x_b: float = top_coast[j1].x
			var rng_b := RandomNumberGenerator.new()
			rng_b.seed = hash("ib_%d_%s" % [row, id])
			for k in range(1, 4):
				var ty: float = float(k) / 4.0
				var y_b: float = lerpf(top_coast[j1].y, bot_coast[j1].y, ty)
				var dx_b: float = rng_b.randf_range(-0.003, 0.003)
				poly.append(Vector2(x_b + dx_b, y_b))

		# Bottom edge (right -> left)
		for j in range(j1, j0 - 1, -1):
			poly.append(bot_coast[j])

		# Left side
		if i == 0:
			# Exterior west coast (runs bottom -> top)
			for ki in range(west_coast.size() - 1, -1, -1):
				poly.append(west_coast[ki])
		else:
			var x_bl: float = top_coast[j0].x
			var rng_bl := RandomNumberGenerator.new()
			rng_bl.seed = hash("ib_l_%d_%s" % [row, id])
			for k in range(3, 0, -1):
				var ty2: float = float(k) / 4.0
				var y_bl: float = lerpf(top_coast[j0].y, bot_coast[j0].y, ty2)
				var dx_bl: float = rng_bl.randf_range(-0.003, 0.003)
				poly.append(Vector2(x_bl + dx_bl, y_bl))

		_polygons[id] = [poly]

		# Centroid = bbox mid of this column segment (offset down slightly so
		# the biome icon floats above the visual center and labels sit below).
		var cx: float = (top_coast[j0].x + top_coast[j1].x) * 0.5
		var cy_top: float = (top_coast[j0].y + top_coast[j1].y) * 0.5
		var cy_bot: float = (bot_coast[j0].y + bot_coast[j1].y) * 0.5
		_centroids[id] = Vector2(cx, (cy_top + cy_bot) * 0.5)

	# ---- Store continent's exterior coastline for overlay rendering ------
	var exterior: PackedVector2Array = PackedVector2Array()
	for p in top_coast:
		exterior.append(p)
	for p in east_coast:
		exterior.append(p)
	for j in range(bot_coast.size() - 1, -1, -1):
		exterior.append(bot_coast[j])
	for ki2 in range(west_coast.size() - 1, -1, -1):
		exterior.append(west_coast[ki2])
	exterior.append(top_coast[0])  # close the loop
	_continent_exteriors.append(exterior)

	# ---- Store internal political borders as line segments ---------------
	for i in range(1, n_cols):
		var j_border: int = i * COAST_SAMPLES_PER_COL
		var border: PackedVector2Array = PackedVector2Array()
		var steps: int = 6
		for k in range(steps + 1):
			var tv: float = float(k) / float(steps)
			var y: float = lerpf(top_coast[j_border].y, bot_coast[j_border].y, tv)
			border.append(Vector2(top_coast[j_border].x, y))
		_continent_internal_borders.append(border)


func _build_archipelago(id: String, x_left: float, x_right: float,
		y_top: float, y_bot: float) -> void:
	var rng := RandomNumberGenerator.new()
	rng.seed = hash("arch_" + id)
	var cx_mid: float = (x_left + x_right) * 0.5
	var cy_mid: float = (y_top + y_bot) * 0.5
	# Three islands arranged like a crooked archipelago: NW, E, S.
	var offsets: Array = [
		[Vector2(-0.045, -0.030), 0.048, 0.028],
		[Vector2( 0.050,  0.004), 0.040, 0.026],
		[Vector2(-0.012,  0.042), 0.044, 0.028],
	]
	var shapes: Array = []
	for off_data in offsets:
		var off: Vector2 = off_data[0]
		var rx: float = off_data[1]
		var ry: float = off_data[2]
		shapes.append(_organic_blob(Vector2(cx_mid + off.x, cy_mid + off.y), rx, ry, rng, 9))
		# Add each island's silhouette as its own exterior polyline so it gets
		# the dark shoreline treatment.
		var exterior: PackedVector2Array = PackedVector2Array(shapes[-1])
		exterior.append(shapes[-1][0])
		_continent_exteriors.append(exterior)
	_polygons[id] = shapes
	_centroids[id] = Vector2(cx_mid - 0.003, cy_mid)


func _generate_ocean_islets() -> void:
	# Scatter small islets in the seas BETWEEN continents so the ocean doesn't
	# look like empty rectangles. Positions are deterministic so they line up
	# with the painted coastlines on every redraw.
	var rng := RandomNumberGenerator.new()
	rng.seed = 0xC0A57
	# Seed spots: roughly on the latitudes of inter-continental seas.
	var hot_spots: Array = [
		# Upper sea (between row 0 and row 1)
		Vector2(0.18, 0.40), Vector2(0.42, 0.41), Vector2(0.62, 0.39),
		Vector2(0.80, 0.42),
		# Atlantic-like gap in the middle row
		Vector2(0.50, 0.54),
		# Southern sea (between row 1 and row 2)
		Vector2(0.12, 0.72), Vector2(0.33, 0.74), Vector2(0.56, 0.70),
		Vector2(0.88, 0.73),
		# Bottom fringe (below southern continents)
		Vector2(0.22, 0.92), Vector2(0.68, 0.94),
	]
	for spot in hot_spots:
		var base: Vector2 = spot + Vector2(rng.randf_range(-0.012, 0.012),
				rng.randf_range(-0.010, 0.010))
		var rx: float = rng.randf_range(0.008, 0.016)
		var ry: float = rng.randf_range(0.006, 0.011)
		var islet: PackedVector2Array = _organic_blob(base, rx, ry, rng, 7)
		_ocean_islets.append(islet)


func _organic_blob(center: Vector2, rx: float, ry: float, rng: RandomNumberGenerator, verts: int) -> PackedVector2Array:
	var poly := PackedVector2Array()
	var phase: float = rng.randf() * TAU
	var phase2: float = rng.randf() * TAU
	for i in range(verts):
		var ang: float = TAU * float(i) / float(verts) + rng.randf_range(-0.06, 0.06)
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

	# Pass 0a: ocean base with subtle vertical gradient (abyss top -> warmer bottom).
	_draw_ocean_gradient(s)
	# Pass 0b: dotted latitude lines suggest a globe / projection grid.
	_draw_latitude_lines(s)
	# Pass 0c: static constellation of flecks + animated drifting motes.
	_draw_ocean_flecks(s)
	_draw_ocean_currents(s)
	# Pass 0d: drifting cloud shadows across the water.
	_draw_cloud_shadows(s)

	# Pass 0e: continental shelf halo around each landmass. This soft cream
	# glow visually ties the continents to the ocean and makes regions feel
	# anchored rather than "floating blobs".
	_draw_shelf_halos(s)

	# Pass 0f: decorative islets scattered across the seas. These are NON
	# interactive (no region hit test) but add rich silhouette variety so the
	# ocean between continents feels like a real archipelagic world.
	_draw_ocean_islets(s)

	# Adjacency edges drawn behind land, dashed so they read as contagion routes in the water.
	for e in _adjacency_edges:
		var a: Vector2 = e[0] * s
		var b: Vector2 = e[1] * s
		_draw_dashed_line(a, b, EDGE_COLOR, 1.3, 6.0, 4.0)

	# Pass 1: shadows (offset down-right to feel like the continents cast on the sea).
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
			# Pulse the selectable ring so it reads as "click me" even through
			# busy map content. Amplitude stays tight so non-selectable regions
			# don't get visually drowned.
			var pulse: float = 0.5 + 0.5 * sin(_time * 4.2)
			ring_color = RING_SELECTABLE
			ring_color.a = 0.65 + 0.35 * pulse
			ring_w = 2.6 + pulse * 1.2
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

			# NOTE: per-region dark borders are no longer drawn here. The
			# solid shoreline is handled once per CONTINENT below so adjacent
			# regions share a seamless coast; internal borders are drawn as
			# thin gold dashed lines so they read as political, not geographic.
			var closed := PackedVector2Array(poly)
			closed.append(poly[0])
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
			# Silence the unused variable warning; border_w is reserved for
			# future per-region stylings while the coastline is continental.
			border_w = border_w

	# Pass 2b: internal political borders (gold dashed between regions in the
	# same continent), drawn UNDER the hard coastline so the coast overrides
	# them at continent edges for a clean silhouette.
	for border in _continent_internal_borders:
		for i in range(border.size() - 1):
			var a: Vector2 = border[i] * s
			var b: Vector2 = border[i + 1] * s
			_draw_dashed_line(a, b, INTERNAL_BORDER, 1.2, 4.0, 3.0)

	# Pass 2c: continent exterior coastlines. A double stroke (dark + faint
	# cream beach rim) gives the silhouette that "painted-map" feel.
	for ext in _continent_exteriors:
		var ext_px := PackedVector2Array()
		for v in ext:
			ext_px.append(v * s)
		draw_polyline(ext_px, COAST_GLOW, 3.2, true)
		draw_polyline(ext_px, COAST_COLOR, 1.6, true)

	# Pass 2d: plague tendrils. For any region whose displayed infection is above
	# PLAGUE_TENDRIL_THRESHOLD, emit a few thin curling strands from the centroid.
	# Strands rotate slowly over _time and pulse in alpha so the heaviest
	# infected regions always feel "alive with the Ash" without spamming
	# particles. Deterministic per-region seed keeps silhouettes stable.
	_draw_plague_tendrils(s)

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

	# Pass 6: decorative compass rose in the bottom-right corner of the map.
	if _compass_rose != null:
		var rose_pos: Vector2 = Vector2(s.x - COMPASS_SIZE - 10.0, s.y - COMPASS_SIZE - 10.0)
		var rose_rect := Rect2(rose_pos, Vector2(COMPASS_SIZE, COMPASS_SIZE))
		draw_texture_rect(_compass_rose, rose_rect, false, Color(1, 1, 1, 0.82))

	# Pass 7: turn-advance flash overlay (fades out over ~0.6s). The flash is
	# a horizontal gradient bloom so it reads as a "dawn breaking" moment
	# rather than a harsh full-screen overlay.
	if _turn_flash_until > 0.0 and _time <= _turn_flash_until:
		var flash_dur: float = 0.6
		var remain: float = clampf((_turn_flash_until - _time) / flash_dur, 0.0, 1.0)
		var a: float = remain * remain * 0.55
		# Two bands: warm gold from bottom, cool cream sheen across middle.
		var gold: Color = Color(0.969, 0.745, 0.341, a)                  # O4 highlight
		for i in range(8):
			var t: float = float(i) / 8.0
			var band: Color = gold
			band.a = a * (1.0 - t) * 0.9
			draw_rect(Rect2(Vector2(0, s.y - (i + 1) * s.y / 8.0),
				Vector2(s.x, s.y / 8.0 + 1.0)), band)
		# A bright horizontal sweep around vertical mid.
		var sheen_y: float = s.y * (0.45 - (1.0 - remain) * 0.15)
		var sheen: Color = Color(0.969, 0.902, 0.659, a * 0.75)          # O5 sheen
		draw_rect(Rect2(Vector2(0, sheen_y - 6.0), Vector2(s.x, 12.0)), sheen)
	elif _turn_flash_until > 0.0 and _time > _turn_flash_until:
		_turn_flash_until = -1.0

	# Pass 8: tooltip for the hovered region (after a short delay).
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


func _draw_ocean_gradient(s: Vector2) -> void:
	# Flat fill then two horizontal bands: deep abyss top, slightly warmer bottom.
	draw_rect(Rect2(Vector2.ZERO, s), OCEAN_COLOR)
	var band_h: float = s.y / 6.0
	# Top gradient band (abyss fade in).
	for i in range(6):
		var t: float = float(i) / 6.0
		var c: Color = OCEAN_DEEP.lerp(OCEAN_COLOR, t)
		c.a = 0.55 * (1.0 - t)
		draw_rect(Rect2(Vector2(0, i * band_h), Vector2(s.x, band_h + 1.0)), c)
	# Bottom warm band (tropical glow).
	for i in range(6):
		var t: float = float(i) / 6.0
		var c2: Color = Color(0.145, 0.110, 0.145, 0.0).lerp(Color(0.186, 0.125, 0.145, 0.35), t)
		draw_rect(Rect2(Vector2(0, s.y - (i + 1) * (band_h * 0.5)), Vector2(s.x, band_h * 0.5 + 1.0)), c2)


func _draw_latitude_lines(s: Vector2) -> void:
	# Three dotted latitude lines (equator + tropics analogue) for "world-map" feel.
	var ys: Array = [s.y * 0.23, s.y * 0.50, s.y * 0.77]
	for y in ys:
		var x: float = 6.0
		while x < s.x - 4.0:
			draw_rect(Rect2(Vector2(x, y), Vector2(2.0, 1.0)), LATITUDE_COLOR)
			x += 6.0


func _draw_ocean_currents(s: Vector2) -> void:
	# Scrolling sine wave "currents": 5 horizontal curves drifting with time.
	# Each curve phase is offset so the ocean never looks static.
	var rows: int = 5
	for i in range(rows):
		var y_base: float = s.y * (0.12 + 0.18 * float(i))
		var phase: float = _time * (0.35 + 0.08 * float(i)) + float(i) * 1.17
		var pts := PackedVector2Array()
		var samples: int = 48
		for j in range(samples + 1):
			var t: float = float(j) / float(samples)
			var x: float = t * s.x
			var y: float = y_base + sin(t * TAU * 2.2 + phase) * 4.0 \
					+ sin(t * TAU * 5.3 + phase * 1.6) * 1.6
			pts.append(Vector2(x, y))
		var col: Color = OCEAN_WAVE
		col.a = OCEAN_WAVE.a * (0.55 + 0.45 * sin(_time * 0.8 + float(i)))
		draw_polyline(pts, col, 1.0, true)


func _draw_cloud_shadows(s: Vector2) -> void:
	# Three large soft ellipses drifting slowly rightward; wrap at map edge.
	var speeds: Array = [12.0, 7.5, 15.0]
	var radii: Array = [Vector2(90, 28), Vector2(120, 34), Vector2(70, 22)]
	var y_rows: Array = [s.y * 0.18, s.y * 0.52, s.y * 0.82]
	var offsets: Array = [0.0, 0.4, 0.75]
	for i in range(3):
		var speed: float = float(speeds[i])
		var radius: Vector2 = radii[i]
		var y: float = float(y_rows[i])
		var off: float = float(offsets[i])
		var wrap_w: float = s.x + radius.x * 2.0
		var x: float = fmod(_time * speed + off * wrap_w, wrap_w) - radius.x
		# Draw as soft disc: a small cluster of tinted circles.
		for k in range(5):
			var dx: float = -radius.x + (2.0 * radius.x) * (float(k) / 4.0)
			var sub_r: float = radius.y * (0.85 - 0.15 * abs(float(k) - 2.0))
			draw_circle(Vector2(x + dx, y), sub_r, CLOUD_COLOR)


func _draw_ocean_islets(s: Vector2) -> void:
	# Decorative islets: dark dot with soft cream halo, matching the coastline style.
	var islet_fill: Color = Color(0.192, 0.137, 0.153, 1.0)  # D2 shadow-warm tone
	for islet in _ocean_islets:
		var poly := PackedVector2Array()
		for v in islet:
			poly.append(v * s)
		# Shadow
		var shad := PackedVector2Array()
		for v in islet:
			shad.append(v * s + Vector2(1.2, 2.0))
		draw_colored_polygon(shad, SHADOW_COLOR)
		# Fill + double coastline.
		draw_colored_polygon(poly, islet_fill)
		var closed := PackedVector2Array(poly)
		closed.append(poly[0])
		draw_polyline(closed, COAST_GLOW, 2.2, true)
		draw_polyline(closed, COAST_COLOR, 1.2, true)


func _draw_shelf_halos(s: Vector2) -> void:
	# Draw each continent polygon slightly upscaled with the shelf color as a
	# soft halo so continents read as landmasses on shelves, not floating blobs.
	for ext in _continent_exteriors:
		if ext.size() < 4:
			continue
		# Centroid for expansion.
		var cx: float = 0.0
		var cy: float = 0.0
		var count: int = ext.size()
		for v in ext:
			cx += v.x
			cy += v.y
		cx /= float(count)
		cy /= float(count)
		var halo := PackedVector2Array()
		var expand: float = 0.012
		for v in ext:
			var dir_x: float = v.x - cx
			var dir_y: float = v.y - cy
			halo.append(Vector2((v.x + dir_x * expand) * s.x,
					(v.y + dir_y * expand) * s.y))
		draw_colored_polygon(halo, OCEAN_SHELF)


func _draw_plague_tendrils(s: Vector2) -> void:
	"""Curling red plague tendrils on heavily infected regions.

	Each region above PLAGUE_TENDRIL_THRESHOLD emits 4-7 thin strands from its
	centroid. Strands are drawn as N small line segments following a sine-
	modulated polar path so they wiggle with _time. Intensity scales with
	infection%, giving a clear progression from "sores" at 50% to a full
	plague halo at 100%. Deterministic per-region seeds keep the composition
	stable between frames.
	"""
	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		if not _centroids.has(id):
			continue
		var display_inf: float = _display_for(id, "infection", float(int(r.get("infection", 0))))
		if display_inf < PLAGUE_TENDRIL_THRESHOLD:
			continue
		var intensity: float = clampf((display_inf - PLAGUE_TENDRIL_THRESHOLD) /
			(100.0 - PLAGUE_TENDRIL_THRESHOLD), 0.0, 1.0)

		var c: Vector2 = _centroids[id] * s
		# Per-region deterministic offset so tendrils on different regions
		# wiggle out of phase with one another.
		var region_seed: float = float(id.hash() & 0xFFFF) / 65535.0 * TAU
		var n_strands: int = 4 + int(round(intensity * 3.0))
		var base_len: float = 14.0 + intensity * 18.0
		var core_alpha: float = 0.40 + 0.55 * intensity

		for i in range(n_strands):
			var ang0: float = TAU * float(i) / float(n_strands) + region_seed + _time * 0.35
			# Tendril: 6 segment polyline following a wiggling arc.
			var pts := PackedVector2Array()
			var segs: int = 6
			for k in range(segs + 1):
				var t: float = float(k) / float(segs)
				var reach: float = base_len * t
				# Ondulation: sine wave applied to angle so the strand curls
				# rather than shoots straight.
				var ang: float = ang0 + sin(_time * 1.8 + i * 0.7 + t * 4.5) * 0.45 * intensity
				# Slight pull back toward centre at the tail for a "snake" feel.
				if t > 0.8:
					reach *= (1.0 - (t - 0.8) * 0.6)
				pts.append(c + Vector2(cos(ang) * reach, sin(ang) * reach * 0.85))
			# Outer strand: R4 faint.
			var outer: Color = PLAGUE_TENDRIL_COLOR
			outer.a = clampf(0.25 + 0.45 * intensity, 0.0, 0.85)
			draw_polyline(pts, outer, 2.2, true)
			# Inner core: R3 for depth.
			var inner: Color = PLAGUE_TENDRIL_CORE
			inner.a = core_alpha
			draw_polyline(pts, inner, 1.0, true)

		# Central pustule: 2-ring dot pulsing with crisis.
		var pulse: float = 0.5 + 0.5 * sin(_time * 3.1 + region_seed)
		var pust_r: float = 2.4 + intensity * 2.6 + pulse * 0.7
		var pust_col: Color = PLAGUE_TENDRIL_CORE
		pust_col.a = 0.35 + 0.45 * intensity
		draw_circle(c, pust_r, pust_col)
		var pust_hi: Color = PLAGUE_TENDRIL_COLOR
		pust_hi.a = 0.70 * intensity
		draw_circle(c, pust_r * 0.55, pust_hi)


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
	_compass_rose = _safe_load_texture(COMPASS_ROSE_PATH)


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
