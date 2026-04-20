class_name RegionGrid
extends RefCounted

const CONTROL_THRESHOLD: int = 60
const PROPAGATION_RATE: float = 0.10
const RESISTANCE_FACTOR: float = 0.8

var regions: Dictionary = {}
var region_order: Array = []
var grid_cols: int = 4
var grid_rows: int = 3

var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func initialize(region_defs_root: Dictionary) -> void:
	_rng.randomize()
	regions.clear()
	region_order.clear()

	var grid_size: Dictionary = region_defs_root.get("grid_size", {"cols": 4, "rows": 3})
	grid_cols = int(grid_size.get("cols", 4))
	grid_rows = int(grid_size.get("rows", 3))

	var defs: Array = region_defs_root.get("regions", [])
	for def in defs:
		var id: String = String(def.get("id", ""))
		if id.is_empty():
			continue
		var start: Dictionary = def.get("start", {})
		regions[id] = {
			"id": id,
			"name": String(def.get("name", id)),
			"short": String(def.get("short", id)),
			"grid": def.get("grid", [0, 0]),
			"neighbors": def.get("neighbors", []),
			"influence": clampi(int(start.get("influence", 0)), 0, 100),
			"infection": clampi(int(start.get("infection", 0)), 0, 100),
			"stability": clampi(int(start.get("stability", 50)), 0, 100)
		}
		region_order.append(id)


func has_region(region_id: String) -> bool:
	return regions.has(region_id)


func get_region(region_id: String) -> Dictionary:
	return regions.get(region_id, {})


func apply_regional_effect(region_id: String, effect: Dictionary) -> void:
	if not regions.has(region_id):
		return
	var region: Dictionary = regions[region_id]
	for key in effect.keys():
		var k: String = String(key)
		if k in ["influence", "infection", "stability"]:
			region[k] = clampi(int(region[k]) + int(effect[k]), 0, 100)
	regions[region_id] = region


func apply_adjacent_effect(region_id: String, effect: Dictionary) -> void:
	if not regions.has(region_id):
		return
	var neighbors: Array = regions[region_id].get("neighbors", [])
	for nid in neighbors:
		apply_regional_effect(String(nid), effect)


# Distributes a delta amount of a stat across N regions, choosing smart targets.
# mode: "boost_lowest_influence" | "drop_highest_influence" | "spread_infection" | "heal_infection"
func distribute_effect(mode: String, delta_magnitude: int, stat: String, count: int = 1) -> Array:
	var affected: Array = []
	if count <= 0 or delta_magnitude == 0:
		return affected

	var candidates: Array = regions.keys()
	match mode:
		"boost_lowest_influence":
			candidates.sort_custom(func(a, b): return int(regions[a]["influence"]) < int(regions[b]["influence"]))
			# Prefer regions not yet controlled and not fully hostile (influence > 5).
			candidates = candidates.filter(func(id): return int(regions[id]["influence"]) < CONTROL_THRESHOLD)
		"drop_highest_influence":
			candidates.sort_custom(func(a, b): return int(regions[a]["influence"]) > int(regions[b]["influence"]))
			candidates = candidates.filter(func(id): return int(regions[id]["influence"]) >= 30)
		"spread_infection":
			candidates.sort_custom(func(a, b): return int(regions[a]["infection"]) > int(regions[b]["infection"]))
		"heal_infection":
			candidates.sort_custom(func(a, b): return int(regions[a]["infection"]) > int(regions[b]["infection"]))
			candidates = candidates.filter(func(id): return int(regions[id]["infection"]) > 0)
		"boost_stability":
			candidates.sort_custom(func(a, b): return int(regions[a]["stability"]) < int(regions[b]["stability"]))
		"drop_stability":
			candidates.sort_custom(func(a, b): return int(regions[a]["stability"]) > int(regions[b]["stability"]))

	var targets: Array = candidates.slice(0, min(count, candidates.size()))
	for tid in targets:
		apply_regional_effect(String(tid), { stat: delta_magnitude })
		affected.append(tid)
	return affected


# Core propagation step: neighbors infect each other proportionally to diff, dampened by influence.
func propagate_infection(global_crisis_decay: int = 0) -> void:
	var deltas: Dictionary = {}
	for id in region_order:
		var r: Dictionary = regions[id]
		var delta: float = 0.0
		for nid in r.get("neighbors", []):
			if not regions.has(nid):
				continue
			var n: Dictionary = regions[nid]
			var diff: float = float(int(n["infection"]) - int(r["infection"]))
			if diff > 0.0:
				var resistance: float = 1.0 - (float(r["influence"]) / 100.0) * RESISTANCE_FACTOR
				delta += diff * PROPAGATION_RATE * resistance
		deltas[id] = delta

	for id in region_order:
		var r2: Dictionary = regions[id]
		var new_inf: int = int(round(float(r2["infection"]) + float(deltas[id]) - float(global_crisis_decay)))
		r2["infection"] = clampi(new_inf, 0, 100)
		regions[id] = r2


# Applies a small per-turn influence drift: player regions bleed slightly; hostile regions creep up.
func apply_passive_influence_drift(drift: int = 1) -> void:
	for id in region_order:
		var r: Dictionary = regions[id]
		if int(r["infection"]) >= 50:
			r["influence"] = clampi(int(r["influence"]) - drift, 0, 100)
		regions[id] = r


func controlled_count(threshold: int = CONTROL_THRESHOLD) -> int:
	var count: int = 0
	for id in region_order:
		if int(regions[id]["influence"]) >= threshold:
			count += 1
	return count


func global_crisis() -> int:
	if region_order.is_empty():
		return 0
	var total: float = 0.0
	for id in region_order:
		total += float(regions[id]["infection"])
	return int(round(total / float(region_order.size())))


func global_stability() -> int:
	if region_order.is_empty():
		return 50
	var total: float = 0.0
	for id in region_order:
		total += float(regions[id]["stability"])
	return int(round(total / float(region_order.size())))


# Returns an ordered array (by region_order) of plain dictionaries, safe to pass to the UI.
func snapshot() -> Array:
	var out: Array = []
	for id in region_order:
		var r: Dictionary = regions[id]
		out.append({
			"id": id,
			"name": r["name"],
			"short": r["short"],
			"grid": r["grid"],
			"neighbors": r["neighbors"],
			"influence": int(r["influence"]),
			"infection": int(r["infection"]),
			"stability": int(r["stability"])
		})
	return out
