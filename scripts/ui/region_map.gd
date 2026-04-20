extends Control

signal region_clicked(region_id: String)
signal region_hovered(region_id: String)

const CONTROL_THRESHOLD: int = 60
const COL_COUNT: int = 4
const ROW_COUNT: int = 3
const VERT_COUNT: int = 11

const OCEAN_COLOR: Color = Color(0.045, 0.075, 0.125)
const OCEAN_GLOW: Color = Color(0.08, 0.14, 0.22, 0.55)
const LAND_RIVAL: Color = Color(0.42, 0.18, 0.22)
const LAND_NEUTRAL: Color = Color(0.36, 0.38, 0.32)
const LAND_PLAYER: Color = Color(0.26, 0.62, 0.36)
const INFECTION_COLOR: Color = Color(0.95, 0.16, 0.13)
const EDGE_COLOR: Color = Color(0.60, 0.78, 0.92, 0.45)
const BORDER_COLOR: Color = Color(0.05, 0.08, 0.11, 0.95)
const RING_CONTROLLED: Color = Color(0.60, 1.00, 0.65, 0.9)
const RING_SELECTABLE: Color = Color(1.00, 0.88, 0.28, 1.0)
const RING_HOVER: Color = Color(1, 1, 1, 0.45)
const SHADOW_COLOR: Color = Color(0, 0, 0, 0.42)
const STAR_COLOR: Color = Color(0.25, 0.85, 1.0, 0.9)

var _snapshot: Array = []
var _polygons: Dictionary = {}        # id -> Array[PackedVector2Array] (normalized 0..1)
var _centroids: Dictionary = {}       # id -> Vector2 normalized
var _adjacency_edges: Array = []      # [[Vector2, Vector2, "direction_label"], ...]
var _selectable_ids: Dictionary = {}
var _selection_active: bool = false
var _hover_id: String = ""
var _time: float = 0.0


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_process(true)


func _process(delta: float) -> void:
	_time += delta
	if not _snapshot.is_empty():
		queue_redraw()


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
	for r in _snapshot:
		var id: String = String(r.get("id", ""))
		if not _polygons.has(id):
			continue
		var influence: int = int(r.get("influence", 0))
		var infection: int = int(r.get("infection", 0))
		var fill: Color = _influence_color(influence)
		var inf_alpha: float = clampf(float(infection) / 100.0 * 0.72, 0.0, 0.72)
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
				var ov: Color = INFECTION_COLOR
				ov.a = inf_alpha
				draw_colored_polygon(poly, ov)

			var closed := PackedVector2Array(poly)
			closed.append(poly[0])
			draw_polyline(closed, BORDER_COLOR, border_w, true)
			if ring_color.a > 0.0:
				draw_polyline(closed, ring_color, ring_w, true)
			if _hover_id == id:
				draw_polyline(closed, RING_HOVER, 1.2, true)

	# Pass 3: labels.
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
			# Text shadow for readability over any tint.
			draw_string(font, c - Vector2(ns.x / 2.0, -2.0) + Vector2(1, 1), short_name,
				HORIZONTAL_ALIGNMENT_LEFT, -1, name_size, Color(0, 0, 0, 0.6))
			draw_string(font, c - Vector2(ns.x / 2.0, -2.0), short_name,
				HORIZONTAL_ALIGNMENT_LEFT, -1, name_size, Color(1, 1, 1, 0.98))
			draw_string(font, c - Vector2(ss.x / 2.0, -16.0) + Vector2(1, 1), stats_text,
				HORIZONTAL_ALIGNMENT_LEFT, -1, stats_size, Color(0, 0, 0, 0.5))
			draw_string(font, c - Vector2(ss.x / 2.0, -16.0), stats_text,
				HORIZONTAL_ALIGNMENT_LEFT, -1, stats_size, Color(1, 1, 1, 0.88))

	# Pass 4: pulse on the most-infected region (the outbreak focus).
	var worst_id: String = _most_infected_id(40)
	if worst_id != "" and _centroids.has(worst_id):
		var c: Vector2 = _centroids[worst_id] * s
		var t: float = (sin(_time * 3.5) + 1.0) * 0.5  # 0..1
		var radius: float = 7.0 + t * 10.0
		var col: Color = INFECTION_COLOR
		col.a = 0.18 + 0.42 * (1.0 - t)
		draw_arc(c, radius, 0, TAU, 32, col, 2.2, true)
		col.a = 0.85
		draw_circle(c, 2.4, col)

	# Pass 5: capital star on each player-controlled region.
	for r in _snapshot:
		if int(r.get("influence", 0)) < CONTROL_THRESHOLD:
			continue
		var id: String = String(r.get("id", ""))
		if not _centroids.has(id):
			continue
		var c: Vector2 = _centroids[id] * s + Vector2(0, -18)
		_draw_star(c, 4.5, STAR_COLOR)


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


func _most_infected_id(min_infection: int) -> String:
	var worst: int = min_infection - 1
	var worst_id: String = ""
	for r in _snapshot:
		var inf: int = int(r.get("infection", 0))
		if inf > worst:
			worst = inf
			worst_id = String(r.get("id", ""))
	return worst_id


func _influence_color(influence: int) -> Color:
	var f: float = clampf(float(influence) / 100.0, 0.0, 1.0)
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
	var id: String = _region_at(pos)
	if id != _hover_id:
		_hover_id = id
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
