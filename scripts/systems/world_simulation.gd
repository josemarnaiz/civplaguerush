class_name WorldSimulation
extends RefCounted

const RegionGridClass = preload("res://scripts/systems/region_grid.gd")

var config: Dictionary = {}
var region_defs: Dictionary = {}
var region_grid: RefCounted
var world_state: Dictionary = {}
var turn_index: int = 0
var turns_total: int = 0

# Last turn's propagation report, for UI/feedback.
var last_propagation_report: Dictionary = {}


func initialize(base_config: Dictionary, meta_modifiers: Dictionary = {}, region_definitions: Dictionary = {}) -> void:
	config = base_config
	region_defs = region_definitions
	turn_index = 0
	turns_total = int(config.get("turns_per_run", 24))

	region_grid = RegionGridClass.new()
	region_grid.initialize(region_defs)

	var base_state: Dictionary = config.get("starting_values", {})
	world_state = {
		"stability": 0,
		"influence": clampi(int(base_state.get("influence", 50)), 0, 100),
		"resources": clampi(int(base_state.get("resources", 50)), 0, 100),
		"crisis": 0,
		"control_regions": 0
	}

	# Apply meta-modifier stability boost as a flat bonus to every region, then derive.
	var stability_bonus: int = int(meta_modifiers.get("start_stability", 0))
	if stability_bonus != 0:
		for id in region_grid.region_order:
			region_grid.apply_regional_effect(String(id), { "stability": stability_bonus })

	_recompute_derived()


# --- Effects ---------------------------------------------------------------

# Legacy-friendly global effects. Keys:
#   influence, resources  -> pure global pools
#   stability             -> applied uniformly to every region (derived global)
#   crisis                -> translated to regional infection change on hotspots
#   control_regions       -> translated to influence boost/drop on smart targets
func apply_effects(effects: Dictionary) -> void:
	for key in effects.keys():
		var k: String = String(key)
		var delta: int = int(effects[key])
		if delta == 0:
			continue

		match k:
			"influence", "resources":
				world_state[k] = int(world_state.get(k, 0)) + delta
			"stability":
				for id in region_grid.region_order:
					region_grid.apply_regional_effect(String(id), { "stability": delta })
			"control_regions":
				if delta > 0:
					region_grid.distribute_effect("boost_lowest_influence", 15, "influence", delta)
				else:
					region_grid.distribute_effect("drop_highest_influence", -15, "influence", -delta)
			"crisis":
				# Route crisis change through 2 hotspots; magnitude roughly matches legacy balance.
				var mag: int = clampi(delta * 2, -30, 30)
				if delta > 0:
					region_grid.distribute_effect("spread_infection", mag, "infection", 2)
				else:
					region_grid.distribute_effect("heal_infection", mag, "infection", 2)

	world_state["influence"] = clampi(int(world_state["influence"]), 0, 100)
	world_state["resources"] = clampi(int(world_state["resources"]), 0, 100)
	_recompute_derived()


# Apply a regional effect directly (new API for Phase 2 regional events).
func apply_regional_effect(region_id: String, effect: Dictionary) -> void:
	region_grid.apply_regional_effect(region_id, effect)
	_recompute_derived()


# Phase 2: apply a choice's regional payload to the resolved target region.
# Accepts the same keys as apply_regional_effect (influence, infection, stability).
func apply_effects_regional(target_id: String, effects: Dictionary) -> void:
	if target_id.is_empty() or effects.is_empty():
		return
	region_grid.apply_regional_effect(target_id, effects)
	_recompute_derived()


# Phase 2: apply a choice's adjacent payload to every neighbor of the target.
func apply_effects_adjacent(target_id: String, effects: Dictionary) -> void:
	if target_id.is_empty() or effects.is_empty():
		return
	region_grid.apply_adjacent_effect(target_id, effects)
	_recompute_derived()


func apply_passive_turn_effects(meta_modifiers: Dictionary) -> void:
	world_state["resources"] = clampi(int(world_state["resources"]) + int(meta_modifiers.get("resources_per_turn", 0)), 0, 100)

	# Infection propagation between neighbors, with meta decay softening the blow.
	var decay: int = int(meta_modifiers.get("crisis_decay", 0))
	var before_crisis: int = region_grid.global_crisis()
	region_grid.propagate_infection(decay)
	region_grid.apply_passive_influence_drift(1)

	# Rising pressure: push infection up slightly in the most infected region to keep tension.
	region_grid.distribute_effect("spread_infection", 2, "infection", 1)

	_recompute_derived()
	last_propagation_report = {
		"crisis_before": before_crisis,
		"crisis_after": world_state["crisis"]
	}


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
		"turns_total": turns_total,
		"regions": region_grid.snapshot()
	}


# --- Snapshots / helpers ---------------------------------------------------

func regions_snapshot() -> Array:
	return region_grid.snapshot()


func controlled_region_ids(threshold: int = 60) -> Array:
	var out: Array = []
	for id in region_grid.region_order:
		if int(region_grid.regions[id]["influence"]) >= threshold:
			out.append(id)
	return out


# --- Internal --------------------------------------------------------------

func _recompute_derived() -> void:
	world_state["crisis"] = region_grid.global_crisis()
	world_state["stability"] = region_grid.global_stability()
	world_state["control_regions"] = region_grid.controlled_count()
