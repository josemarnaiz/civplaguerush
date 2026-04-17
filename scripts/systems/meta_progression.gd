class_name MetaProgression
extends RefCounted

const SAVE_PATH := "user://meta_progress.json"

var credits: int = 0
var unlocked_techs: Array[String] = []
var chapter_status: Dictionary = {}

var _tech_defs: Array = []


func initialize(tech_defs: Array) -> void:
	_tech_defs = tech_defs.duplicate(true)
	load_state()


func load_state() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		save_state()
		return

	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return

	credits = int(parsed.get("credits", 0))
	unlocked_techs = []
	for tech_id in parsed.get("unlocked_techs", []):
		unlocked_techs.append(String(tech_id))
	chapter_status = parsed.get("chapter_status", {})


func save_state() -> void:
	var payload: Dictionary = {
		"credits": credits,
		"unlocked_techs": unlocked_techs,
		"chapter_status": chapter_status
	}
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file != null:
		file.store_string(JSON.stringify(payload, "\t"))


func award_run_rewards(run_result: Dictionary, rewards_cfg: Dictionary) -> int:
	var gained: int = int(rewards_cfg.get("base_credits", 20))
	if String(run_result.get("outcome", "timeout")) == "win":
		gained += int(rewards_cfg.get("win_bonus", 50))
	if bool(run_result.get("chapter_goal_completed", false)):
		gained += int(rewards_cfg.get("chapter_bonus", 20))

	credits += gained
	save_state()
	return gained


func get_available_techs() -> Array:
	var available: Array = []
	for tech in _tech_defs:
		if unlocked_techs.has(String(tech.get("id", ""))):
			continue
		available.append(tech)
	return available


func unlock_tech(tech_id: String) -> bool:
	if unlocked_techs.has(tech_id):
		return false

	var tech_def: Dictionary = {}
	for tech in _tech_defs:
		if String(tech.get("id", "")) == tech_id:
			tech_def = tech
			break

	if tech_def.is_empty():
		return false

	var cost: int = int(tech_def.get("cost", 99999))
	if credits < cost:
		return false

	credits -= cost
	unlocked_techs.append(tech_id)
	save_state()
	return true


func get_run_modifiers() -> Dictionary:
	var modifiers: Dictionary = {
		"start_stability": 0,
		"resources_per_turn": 0,
		"crisis_decay": 0
	}

	for tech in _tech_defs:
		if not unlocked_techs.has(String(tech.get("id", ""))):
			continue
		var effects: Dictionary = tech.get("effects", {})
		modifiers["start_stability"] += int(effects.get("start_stability", 0))
		modifiers["resources_per_turn"] += int(effects.get("resources_per_turn", 0))
		modifiers["crisis_decay"] += int(effects.get("crisis_decay", 0))

	return modifiers


func set_chapter_completed(chapter_id: String) -> void:
	chapter_status[chapter_id] = "completed"
	save_state()
