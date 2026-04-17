class_name CampaignManager
extends RefCounted

var chapter_data: Dictionary = {}


func initialize(data: Dictionary) -> void:
	chapter_data = data.duplicate(true)


func chapter_id() -> String:
	return String(chapter_data.get("chapter_id", "chapter_unknown"))


func chapter_title() -> String:
	return String(chapter_data.get("title", "Chapter"))


func chapter_intro() -> String:
	return String(chapter_data.get("intro", ""))


func evaluate_run_for_chapter(run_state: Dictionary) -> bool:
	return int(run_state.get("control_regions", 0)) >= 6 and int(run_state.get("crisis", 100)) < 70


func chapter_goal_text() -> String:
	return String(chapter_data.get("primary_goal", "Complete chapter objective."))
