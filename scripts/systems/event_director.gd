class_name EventDirector
extends RefCounted

# Resolves event templates against the current RegionGrid so the UI receives
# fully-rendered events with `_target_region_id` set (for auto-resolved
# templates) or a `_candidates` list (for player-targeted events).

const CONTROL_THRESHOLD: int = 60

var _events: Array = []
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func initialize(events: Array) -> void:
	_events = events.duplicate(true)
	_rng.randomize()


# region_grid: RegionGrid (RefCounted). Optional — if null, templated events
# are skipped and only global events are emitted.
func next_choices(decision_count: int, region_grid = null) -> Array:
	if _events.is_empty():
		return []

	var count: int = clampi(decision_count, 1, 4)
	var selected: Array = []
	var used_indexes: Dictionary = {}
	var safety: int = _events.size() * 3

	while selected.size() < count and used_indexes.size() < _events.size() and safety > 0:
		safety -= 1
		var idx: int = _rng.randi_range(0, _events.size() - 1)
		if used_indexes.has(idx):
			continue
		used_indexes[idx] = true

		var resolved: Dictionary = _resolve(_events[idx], region_grid)
		if String(resolved.get("_kind", "")) == "skip":
			continue
		selected.append(resolved)

	return selected


# --- Resolution ------------------------------------------------------------

func _resolve(event: Dictionary, region_grid) -> Dictionary:
	var out: Dictionary = event.duplicate(true)
	var template: String = String(out.get("template", ""))

	if template.is_empty():
		out["_kind"] = "global"
		return out

	if region_grid == null:
		# Can't resolve templated events without a grid.
		return { "_kind": "skip" }

	if template == "player_chooses":
		var filter: String = String(out.get("target_filter", "any"))
		var candidates: Array = _candidates_for(filter, region_grid)
		if candidates.is_empty():
			return { "_kind": "skip" }
		out["_kind"] = "player_chooses"
		out["_candidates"] = candidates
		return out

	var target_id: String = _pick_region(template, region_grid)
	if target_id.is_empty():
		return { "_kind": "skip" }

	var region: Dictionary = region_grid.get_region(target_id)
	out["_kind"] = "regional_auto"
	out["_target_region_id"] = target_id
	out["title"] = format_text(String(out.get("title", "")), region)
	out["description"] = format_text(String(out.get("description", "")), region)
	var rendered_choices: Array = []
	for choice in out.get("choices", []):
		var c: Dictionary = choice.duplicate(true)
		c["label"] = format_text(String(c.get("label", "")), region)
		rendered_choices.append(c)
	out["choices"] = rendered_choices
	return out


# --- Template strategies ---------------------------------------------------

func _pick_region(template: String, region_grid) -> String:
	var ids: Array = region_grid.region_order.duplicate()
	match template:
		"most_infected":
			ids.sort_custom(func(a, b): return int(region_grid.regions[a]["infection"]) > int(region_grid.regions[b]["infection"]))
			ids = _filter_infected_above(ids, region_grid, 10)
		"least_influence":
			ids.sort_custom(func(a, b): return int(region_grid.regions[a]["influence"]) < int(region_grid.regions[b]["influence"]))
			ids = _filter_influence_below(ids, region_grid, CONTROL_THRESHOLD)
		"bordering_controlled":
			ids = _filter_bordering_controlled(ids, region_grid)
			ids.sort_custom(func(a, b): return int(region_grid.regions[a]["infection"]) > int(region_grid.regions[b]["infection"]))
		"frontier_controlled":
			ids = _filter_frontier_controlled(ids, region_grid)
		_:
			# Unknown template: pick at random so a new tag never silently kills an event.
			ids.shuffle()
	if ids.is_empty():
		return ""
	return String(ids[0])


func _filter_infected_above(ids: Array, region_grid, threshold: int) -> Array:
	var out: Array = []
	for id in ids:
		if int(region_grid.regions[id]["infection"]) > threshold:
			out.append(id)
	return out


func _filter_influence_below(ids: Array, region_grid, threshold: int) -> Array:
	var out: Array = []
	for id in ids:
		if int(region_grid.regions[id]["influence"]) < threshold:
			out.append(id)
	return out


func _filter_bordering_controlled(ids: Array, region_grid) -> Array:
	var out: Array = []
	for id in ids:
		var region: Dictionary = region_grid.regions[id]
		if int(region["influence"]) >= CONTROL_THRESHOLD:
			continue
		for nid in region.get("neighbors", []):
			if region_grid.regions.has(nid) and int(region_grid.regions[nid]["influence"]) >= CONTROL_THRESHOLD:
				out.append(id)
				break
	return out


func _filter_frontier_controlled(ids: Array, region_grid) -> Array:
	var out: Array = []
	for id in ids:
		var region: Dictionary = region_grid.regions[id]
		if int(region["influence"]) < CONTROL_THRESHOLD:
			continue
		for nid in region.get("neighbors", []):
			if region_grid.regions.has(nid) and int(region_grid.regions[nid]["influence"]) < CONTROL_THRESHOLD:
				out.append(id)
				break
	return out


func _candidates_for(filter: String, region_grid) -> Array:
	var ids: Array = region_grid.region_order.duplicate()
	var out: Array = []
	for id in ids:
		var region: Dictionary = region_grid.regions[id]
		match filter:
			"uncontrolled":
				if int(region["influence"]) < CONTROL_THRESHOLD:
					out.append(id)
			"controlled":
				if int(region["influence"]) >= CONTROL_THRESHOLD:
					out.append(id)
			"infected":
				if int(region["infection"]) >= 30:
					out.append(id)
			"healthy":
				if int(region["infection"]) < 20:
					out.append(id)
			_:
				out.append(id)
	return out


# --- Placeholders ----------------------------------------------------------

# Public so RunScene can format a `player_chooses` event after the player clicks.
func format_text(source: String, region: Dictionary) -> String:
	return source \
		.replace("{region.name}", String(region.get("name", ""))) \
		.replace("{region.short}", String(region.get("short", "")))
