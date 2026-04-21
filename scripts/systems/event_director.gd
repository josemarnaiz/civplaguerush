class_name EventDirector
extends RefCounted

# Resolves event templates against the current RegionGrid so the UI receives
# fully-rendered events with `_target_region_id` set (for auto-resolved
# templates) or a `_candidates` list (for player-targeted events).

const CONTROL_THRESHOLD: int = 60
const RECENT_EVENT_BLOCK: int = 6

var _events: Array = []
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()
var _seen_counts: Dictionary = {}
var _recent_event_ids: Array[String] = []
var _locale: String = "en"


func initialize(events: Array, locale: String = "en") -> void:
	_events = events.duplicate(true)
	_rng.randomize()
	_seen_counts.clear()
	_recent_event_ids.clear()
	_locale = locale


# region_grid: RegionGrid (RefCounted). Optional — if null, templated events
# are skipped and only global events are emitted.
func next_choices(decision_count: int, region_grid = null) -> Array:
	if _events.is_empty():
		return []

	var count: int = clampi(decision_count, 1, 4)
	var selected: Array = []
	var used_indexes: Dictionary = {}
	var selected_templates: Dictionary = {}
	var has_targeted: bool = false
	var safety: int = _events.size() * 3

	while selected.size() < count and used_indexes.size() < _events.size() and safety > 0:
		safety -= 1
		var slots_left: int = count - selected.size()
		var require_targeted: bool = (not has_targeted and slots_left == 1)
		var idx: int = _pick_event_index(used_indexes, selected_templates, require_targeted)
		if idx < 0 and require_targeted:
			# Fall back gracefully if no targeted template is currently resolvable.
			idx = _pick_event_index(used_indexes, selected_templates, false)
		if idx < 0 or used_indexes.has(idx):
			continue
		used_indexes[idx] = true

		var source_event: Dictionary = _events[idx]
		var resolved: Dictionary = _resolve(source_event, region_grid)
		if String(resolved.get("_kind", "")) == "skip":
			continue
		selected.append(resolved)
		var template: String = String(source_event.get("template", ""))
		if template != "":
			has_targeted = true
			selected_templates[template] = true
		_mark_event_used(String(source_event.get("id", "")))

	return selected


# --- Resolution ------------------------------------------------------------

func _resolve(event: Dictionary, region_grid) -> Dictionary:
	var out: Dictionary = event.duplicate(true)
	var template: String = String(out.get("template", ""))
	out["title"] = _localize(out, "title")
	out["description"] = _localize(out, "description")
	var localized_choices: Array = []
	for choice in out.get("choices", []):
		var c: Dictionary = choice.duplicate(true)
		c["label"] = _localize(c, "label")
		localized_choices.append(c)
	localized_choices.shuffle()
	out["choices"] = localized_choices

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


func _pick_event_index(used_indexes: Dictionary, selected_templates: Dictionary, require_targeted: bool) -> int:
	var best_idx: int = -1
	var best_score: float = 999999.0
	for i in range(_events.size()):
		if used_indexes.has(i):
			continue
		var e: Dictionary = _events[i]
		var id: String = String(e.get("id", ""))
		var template: String = String(e.get("template", ""))
		if require_targeted and template == "":
			continue
		var seen: int = int(_seen_counts.get(id, 0))
		var recent_penalty: float = 1000.0 if _recent_event_ids.has(id) else 0.0
		# Strongly discourage repeating the same template in one turn; this keeps
		# the choice set mixed (e.g. not 3x border crises in a row).
		var template_penalty: float = 85.0 if (template != "" and selected_templates.has(template)) else 0.0
		var score: float = float(seen) * 10.0 + recent_penalty + template_penalty + _rng.randf()
		if score < best_score:
			best_score = score
			best_idx = i
	return best_idx


func _mark_event_used(id: String) -> void:
	if id == "":
		return
	_seen_counts[id] = int(_seen_counts.get(id, 0)) + 1
	_recent_event_ids.append(id)
	while _recent_event_ids.size() > RECENT_EVENT_BLOCK:
		_recent_event_ids.remove_at(0)


func _localize(source: Dictionary, base_key: String) -> String:
	if _locale == "es":
		var loc_key: String = "%s_es" % base_key
		if source.has(loc_key):
			return String(source.get(loc_key, ""))
	return String(source.get(base_key, ""))


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
