class_name WorldSimulation
extends RefCounted

var config: Dictionary = {}
var world_state: Dictionary = {}
var turn_index: int = 0
var turns_total: int = 0


func initialize(base_config: Dictionary, meta_modifiers: Dictionary = {}) -> void:
	config = base_config
	turn_index = 0
	turns_total = int(config.get("turns_per_run", 24))

	var base_state: Dictionary = config.get("starting_values", {})
	world_state = {
		"stability": clampi(int(base_state.get("stability", 50)) + int(meta_modifiers.get("start_stability", 0)), 0, 100),
		"influence": clampi(int(base_state.get("influence", 50)), 0, 100),
		"resources": clampi(int(base_state.get("resources", 50)), 0, 100),
		"crisis": clampi(int(base_state.get("crisis", 20)), 0, 100),
		"control_regions": clampi(int(base_state.get("control_regions", 2)), 0, int(config.get("regions_total", 12)))
	}


func apply_effects(effects: Dictionary) -> void:
	for key in effects.keys():
		var current_value: int = int(world_state.get(key, 0))
		var delta: int = int(effects[key])
		world_state[key] = current_value + delta

	world_state["stability"] = clampi(int(world_state["stability"]), 0, 100)
	world_state["influence"] = clampi(int(world_state["influence"]), 0, 100)
	world_state["resources"] = clampi(int(world_state["resources"]), 0, 100)
	world_state["crisis"] = clampi(int(world_state["crisis"]), 0, 100)
	world_state["control_regions"] = clampi(int(world_state["control_regions"]), 0, int(config.get("regions_total", 12)))


func apply_passive_turn_effects(meta_modifiers: Dictionary) -> void:
	world_state["resources"] = clampi(int(world_state["resources"]) + int(meta_modifiers.get("resources_per_turn", 0)), 0, 100)
	world_state["crisis"] = clampi(int(world_state["crisis"]) - int(meta_modifiers.get("crisis_decay", 0)), 0, 100)

	# Rising pressure guarantees that each run remains tense.
	world_state["crisis"] = clampi(int(world_state["crisis"]) + 2, 0, 100)
	world_state["stability"] = clampi(int(world_state["stability"]) - 1, 0, 100)


func advance_turn() -> void:
	turn_index += 1


func is_final_turn() -> bool:
	return turn_index >= turns_total


func evaluate_outcome() -> Dictionary:
	var win_cfg: Dictionary = config.get("win_conditions", {})
	var lose_cfg: Dictionary = config.get("lose_conditions", {})

	var is_loss: bool = int(world_state["stability"]) <= int(lose_cfg.get("stability_below", 10))
	is_loss = is_loss or int(world_state["crisis"]) >= int(lose_cfg.get("crisis_above", 90))

	var is_win: bool = int(world_state["control_regions"]) >= int(win_cfg.get("target_control_regions", 8))
	is_win = is_win and int(world_state["crisis"]) <= int(win_cfg.get("max_crisis_for_win", 60))

	var outcome: String = "ongoing"
	if is_loss:
		outcome = "loss"
	elif is_win:
		outcome = "win"
	elif is_final_turn():
		outcome = "timeout"

	return {
		"outcome": outcome,
		"state": world_state.duplicate(true),
		"turn_index": turn_index,
		"turns_total": turns_total
	}
