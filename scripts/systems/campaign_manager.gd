class_name CampaignManager
extends RefCounted

var chapter_data: Dictionary = {}
var locale: String = "en"


func initialize(data: Dictionary) -> void:
	chapter_data = data.duplicate(true)


func set_locale(next_locale: String) -> void:
	locale = "es" if next_locale == "es" else "en"


func chapter_id() -> String:
	return String(chapter_data.get("chapter_id", "chapter_unknown"))


func chapter_title() -> String:
	if locale == "es" and chapter_data.has("title_es"):
		return String(chapter_data.get("title_es", "Capitulo"))
	return String(chapter_data.get("title", "Chapter"))


func chapter_intro() -> String:
	if locale == "es" and chapter_data.has("intro_es"):
		return String(chapter_data.get("intro_es", ""))
	return String(chapter_data.get("intro", ""))


func evaluate_run_for_chapter(run_state: Dictionary) -> bool:
	var req: Dictionary = chapter_data.get("requirements", {})
	var min_control: int = int(req.get("min_control_regions", 6))
	var max_crisis: int = int(req.get("max_crisis", 70))
	var min_stability: int = int(req.get("min_stability", 0))
	var min_influence: int = int(req.get("min_influence", 0))
	return int(run_state.get("control_regions", 0)) >= min_control \
		and int(run_state.get("crisis", 100)) <= max_crisis \
		and int(run_state.get("stability", 0)) >= min_stability \
		and int(run_state.get("influence", 0)) >= min_influence


func chapter_goal_text() -> String:
	var explicit: String = ""
	if locale == "es" and chapter_data.has("primary_goal_es"):
		explicit = String(chapter_data.get("primary_goal_es", ""))
	else:
		explicit = String(chapter_data.get("primary_goal", ""))
	if explicit != "":
		return explicit
	var req: Dictionary = chapter_data.get("requirements", {})
	return "Reach %d control regions with crisis <= %d." % [
		int(req.get("min_control_regions", 6)),
		int(req.get("max_crisis", 70))
	]
