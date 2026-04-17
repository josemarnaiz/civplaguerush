class_name EventDirector
extends RefCounted

var _events: Array = []
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func initialize(events: Array) -> void:
	_events = events.duplicate(true)
	_rng.randomize()


func next_choices(decision_count: int) -> Array:
	if _events.is_empty():
		return []

	var count: int = clampi(decision_count, 1, 4)
	var selected: Array = []
	var used_indexes: Dictionary = {}

	while selected.size() < count and used_indexes.size() < _events.size():
		var idx: int = _rng.randi_range(0, _events.size() - 1)
		if used_indexes.has(idx):
			continue
		used_indexes[idx] = true
		selected.append(_events[idx])

	return selected
