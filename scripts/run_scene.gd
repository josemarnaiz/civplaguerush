extends Control

const WorldSimulationClass = preload("res://scripts/systems/world_simulation.gd")
const EventDirectorClass = preload("res://scripts/systems/event_director.gd")
const MetaProgressionClass = preload("res://scripts/systems/meta_progression.gd")
const CampaignManagerClass = preload("res://scripts/systems/campaign_manager.gd")
const MetricsTrackerClass = preload("res://scripts/systems/metrics_tracker.gd")
const SessionBridgeClass = preload("res://scripts/systems/session_bridge.gd")
const PlatformProfileClass = preload("res://scripts/systems/platform_profile.gd")

@onready var turn_label: Label = $Margin/VBox/Header/TurnLabel
@onready var chapter_label: Label = $Margin/VBox/Header/ChapterLabel
@onready var stats_label: Label = $Margin/VBox/StatePanel/StatsLabel
@onready var event_title_label: Label = $Margin/VBox/EventPanel/EventVBox/EventTitle
@onready var event_description_label: Label = $Margin/VBox/EventPanel/EventVBox/EventDescription
@onready var choices_container: VBoxContainer = $Margin/VBox/EventPanel/EventVBox/Choices
@onready var progress_label: Label = $Margin/VBox/Footer/ProgressLabel
@onready var back_button: Button = $Margin/VBox/Footer/BackButton

var world_simulation
var event_director
var meta_progression
var campaign_manager
var metrics_tracker
var platform_profile

var config: Dictionary = {}
var events_data: Array = []
var tech_data: Array = []
var chapter_data: Dictionary = {}

var current_turn_events: Array = []
var current_event_index: int = 0
var decisions_this_turn: int = 0


func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	platform_profile = PlatformProfileClass.new()
	_apply_platform_profile()

	config = _load_json_dict("res://data/run_config.json")
	events_data = _load_json_array("res://data/events.json")
	tech_data = _load_json_array("res://data/techs.json")
	chapter_data = _load_json_dict("res://data/campaign_ch1.json")

	world_simulation = WorldSimulationClass.new()
	event_director = EventDirectorClass.new()
	meta_progression = MetaProgressionClass.new()
	campaign_manager = CampaignManagerClass.new()
	metrics_tracker = MetricsTrackerClass.new()

	meta_progression.initialize(tech_data)
	campaign_manager.initialize(chapter_data)
	event_director.initialize(events_data)
	world_simulation.initialize(config, meta_progression.get_run_modifiers())
	metrics_tracker.start_run()

	chapter_label.text = campaign_manager.chapter_title()
	_start_turn()


func _apply_platform_profile() -> void:
	var profile: Dictionary = platform_profile.current_profile()
	var min_size: Vector2i = profile.get("button_min_size", Vector2i(220, 54))
	back_button.custom_minimum_size = Vector2(min_size.x, min_size.y)


func _start_turn() -> void:
	var min_decisions: int = int(config.get("decisions_per_turn_min", 3))
	var max_decisions: int = int(config.get("decisions_per_turn_max", 4))
	decisions_this_turn = randi_range(min_decisions, max_decisions)
	current_turn_events = event_director.next_choices(decisions_this_turn)
	current_event_index = 0

	_render_state()
	_render_current_event()


func _render_state() -> void:
	turn_label.text = "Turn %d / %d" % [world_simulation.turn_index + 1, world_simulation.turns_total]
	var s: Dictionary = world_simulation.world_state
	stats_label.text = "Stability: %d   Influence: %d   Resources: %d   Crisis: %d   Regions: %d" % [
		int(s.get("stability", 0)),
		int(s.get("influence", 0)),
		int(s.get("resources", 0)),
		int(s.get("crisis", 0)),
		int(s.get("control_regions", 0))
	]
	progress_label.text = "Decision %d / %d this turn" % [current_event_index + 1, max(1, decisions_this_turn)]


func _render_current_event() -> void:
	for child in choices_container.get_children():
		child.queue_free()

	if current_turn_events.is_empty() or current_event_index >= current_turn_events.size():
		_finalize_turn()
		return

	var event_data: Dictionary = current_turn_events[current_event_index]
	event_title_label.text = String(event_data.get("title", "Unknown Event"))
	event_description_label.text = String(event_data.get("description", "No description."))

	var profile: Dictionary = platform_profile.current_profile()
	var min_size: Vector2i = profile.get("button_min_size", Vector2i(220, 54))

	for choice in event_data.get("choices", []):
		var button := Button.new()
		button.text = String(choice.get("label", "Choose"))
		button.custom_minimum_size = Vector2(min_size.x, min_size.y)
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_container.add_child(button)

	_render_state()


func _on_choice_selected(choice: Dictionary) -> void:
	world_simulation.apply_effects(choice.get("effects", {}))
	current_event_index += 1
	_render_current_event()


func _finalize_turn() -> void:
	world_simulation.apply_passive_turn_effects(meta_progression.get_run_modifiers())
	world_simulation.advance_turn()
	var evaluation: Dictionary = world_simulation.evaluate_outcome()
	if String(evaluation.get("outcome", "ongoing")) == "ongoing":
		_start_turn()
		return

	_finish_run(evaluation)


func _finish_run(evaluation: Dictionary) -> void:
	var final_state: Dictionary = evaluation.get("state", {})
	var chapter_goal_completed: bool = campaign_manager.evaluate_run_for_chapter(final_state)

	var run_result: Dictionary = {
		"outcome": evaluation.get("outcome", "timeout"),
		"state": final_state,
		"turn_index": evaluation.get("turn_index", 0),
		"turns_total": evaluation.get("turns_total", 0),
		"chapter_goal_completed": chapter_goal_completed,
		"chapter_id": campaign_manager.chapter_id(),
		"chapter_title": campaign_manager.chapter_title()
	}

	var credits_gained: int = meta_progression.award_run_rewards(run_result, config.get("meta_rewards", {}))
	if chapter_goal_completed:
		meta_progression.set_chapter_completed(campaign_manager.chapter_id())

	run_result["credits_gained"] = credits_gained
	run_result["credits_total"] = meta_progression.credits
	run_result["chapter_goal_text"] = campaign_manager.chapter_goal_text()

	metrics_tracker.finish_run({
		"outcome": run_result["outcome"],
		"turn_index": run_result["turn_index"],
		"second_run_rate_hint": true,
		"chapter_goal_completed": chapter_goal_completed,
		"credits_gained": credits_gained
	})

	SessionBridgeClass.save_run_result(run_result)
	get_tree().change_scene_to_file("res://scenes/MetaHub.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _load_json_dict(path: String) -> Dictionary:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return {}
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return {}
	return parsed


func _load_json_array(path: String) -> Array:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return []
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_ARRAY:
		return []
	return parsed
