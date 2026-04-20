extends Control

const WorldSimulationClass = preload("res://scripts/systems/world_simulation.gd")
const EventDirectorClass = preload("res://scripts/systems/event_director.gd")
const MetaProgressionClass = preload("res://scripts/systems/meta_progression.gd")
const CampaignManagerClass = preload("res://scripts/systems/campaign_manager.gd")
const MetricsTrackerClass = preload("res://scripts/systems/metrics_tracker.gd")
const SessionBridgeClass = preload("res://scripts/systems/session_bridge.gd")
const PlatformProfileClass = preload("res://scripts/systems/platform_profile.gd")
const LOSS_ALERT_VOLUME_DB: float = -9.0

@onready var turn_label: Label = $Margin/VBox/Header/TurnLabel
@onready var chapter_label: Label = $Margin/VBox/Header/ChapterLabel
@onready var region_map: Control = $Margin/VBox/RegionMap
@onready var stat_stability: Label = $Margin/VBox/StatePanel/StatsBox/Stability/Value
@onready var stat_influence: Label = $Margin/VBox/StatePanel/StatsBox/Influence/Value
@onready var stat_resources: Label = $Margin/VBox/StatePanel/StatsBox/Resources/Value
@onready var stat_crisis: Label = $Margin/VBox/StatePanel/StatsBox/Crisis/Value
@onready var stat_control: Label = $Margin/VBox/StatePanel/StatsBox/Control/Value
@onready var event_icon: TextureRect = $Margin/VBox/EventPanel/EventVBox/EventHeader/EventIcon
@onready var event_title_label: Label = $Margin/VBox/EventPanel/EventVBox/EventHeader/EventTitle
@onready var event_description_label: Label = $Margin/VBox/EventPanel/EventVBox/EventDescription
@onready var choices_container: VBoxContainer = $Margin/VBox/EventPanel/EventVBox/Choices

# Maps each event id (from data/events.json) to its event icon path.
# Icons are optional; missing resources fall back to text-only header.
const EVENT_ICON_PATH_BY_ID: Dictionary = {
	"food_shortage": "res://assets/art/events/event_famine.png",
	"border_uprising": "res://assets/art/events/event_uprising.png",
	"info_leak": "res://assets/art/events/event_espionage.png",
	"pandemic_wave": "res://assets/art/events/event_outbreak.png",
	"golden_opportunity": "res://assets/art/events/event_opportunity.png",
	"outbreak_focus": "res://assets/art/events/event_outbreak.png",
	"frontier_uprising": "res://assets/art/events/event_uprising.png",
	"defector_cell": "res://assets/art/events/event_espionage.png",
	"relief_mission": "res://assets/art/events/event_relief.png",
	"sabotage_strike": "res://assets/art/events/event_sabotage.png",
	"cure_trial": "res://assets/art/events/event_science.png",
	"mass_migration": "res://assets/art/events/event_migration.png",
}
const EVENT_ICON_FALLBACK_PATH: String = "res://assets/art/events/event_outbreak.png"
@onready var progress_label: Label = $Margin/VBox/Footer/ProgressLabel
@onready var back_button: Button = $Margin/VBox/Footer/BackButton

var world_simulation: WorldSimulation
var event_director: EventDirector
var meta_progression: MetaProgression
var campaign_manager: CampaignManager
var metrics_tracker: MetricsTracker
var platform_profile: PlatformProfile

var config: Dictionary = {}
var events_data: Array = []
var tech_data: Array = []
var chapter_data: Dictionary = {}
var region_defs: Dictionary = {}

var current_turn_events: Array = []
var current_event_index: int = 0
var decisions_this_turn: int = 0

# True while the active event is waiting for the player to click a region
# before choices become selectable.
var _awaiting_region_pick: bool = false
var _controlled_regions_prev: Dictionary = {}
var _loss_audio_player: AudioStreamPlayer = null
var _loss_audio_stream: AudioStreamGenerator = null
var _event_icon_cache: Dictionary = {}


func _ready() -> void:
	back_button.pressed.connect(_on_back_pressed)
	platform_profile = PlatformProfileClass.new()
	_apply_platform_profile()

	config = _load_json_dict("res://data/run_config.json")
	events_data = _load_json_array("res://data/events.json")
	tech_data = _load_json_array("res://data/techs.json")
	chapter_data = _load_json_dict("res://data/campaign_ch1.json")
	region_defs = _load_json_dict("res://data/regions.json")

	world_simulation = WorldSimulationClass.new()
	event_director = EventDirectorClass.new()
	meta_progression = MetaProgressionClass.new()
	campaign_manager = CampaignManagerClass.new()
	metrics_tracker = MetricsTrackerClass.new()

	meta_progression.initialize(tech_data)
	campaign_manager.initialize(chapter_data)
	event_director.initialize(events_data)
	world_simulation.initialize(config, meta_progression.get_run_modifiers(), region_defs)
	metrics_tracker.start_run()
	_setup_loss_audio()
	_control_snapshot_sync()

	if region_map.has_method("build_from_snapshot"):
		region_map.build_from_snapshot(world_simulation.regions_snapshot())
	if region_map.has_signal("region_clicked") and not region_map.region_clicked.is_connected(_on_region_clicked):
		region_map.region_clicked.connect(_on_region_clicked)

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
	current_turn_events = event_director.next_choices(decisions_this_turn, world_simulation.region_grid)
	current_event_index = 0

	_render_state()
	_render_current_event()


func _render_state() -> void:
	turn_label.text = "Turn %d / %d" % [world_simulation.turn_index + 1, world_simulation.turns_total]
	var s: Dictionary = world_simulation.world_state
	var target: int = int(config.get("win_conditions", {}).get("target_control_regions", 7))

	stat_stability.text = str(int(s.get("stability", 0)))
	stat_influence.text = str(int(s.get("influence", 0)))
	stat_resources.text = str(int(s.get("resources", 0)))
	stat_crisis.text = str(int(s.get("crisis", 0)))
	stat_control.text = "%d / %d" % [int(s.get("control_regions", 0)), target]

	# Tint crisis value red when it's climbing to warn the player.
	var crisis: int = int(s.get("crisis", 0))
	var crisis_col: Color = Color(0.910, 0.831, 0.706, 1.0) # C4 cream
	if crisis >= 50:
		crisis_col = Color(0.851, 0.329, 0.306, 1.0)        # R4 wound red
	elif crisis >= 30:
		crisis_col = Color(0.780, 0.604, 0.235, 1.0)        # O3 signature gold
	stat_crisis.add_theme_color_override("font_color", crisis_col)

	progress_label.text = "Decision %d / %d this turn" % [current_event_index + 1, max(1, decisions_this_turn)]
	_refresh_region_map()


func _refresh_region_map() -> void:
	if region_map == null:
		return
	if region_map.has_method("refresh"):
		region_map.refresh(world_simulation.regions_snapshot())


func _render_current_event() -> void:
	for child in choices_container.get_children():
		child.queue_free()

	if current_turn_events.is_empty() or current_event_index >= current_turn_events.size():
		_end_region_pick_mode()
		_finalize_turn()
		return

	var event_data: Dictionary = current_turn_events[current_event_index]
	var kind: String = String(event_data.get("_kind", "global"))

	# For player_chooses events we don't know the region yet, so replace the
	# remaining {region.*} placeholders with neutral copy for display only.
	# The raw event_data keeps the templates intact so _on_region_clicked can
	# still format them against the real region once the player picks.
	var pending_pick: bool = (kind == "player_chooses")
	var display_placeholder: Dictionary = { "name": "the chosen region", "short": "the region" }
	event_title_label.text = _display_text(String(event_data.get("title", "Unknown Event")), pending_pick, display_placeholder)
	event_description_label.text = _display_text(String(event_data.get("description", "No description.")), pending_pick, display_placeholder)
	_assign_event_icon(event_data)

	var profile: Dictionary = platform_profile.current_profile()
	var min_size: Vector2i = profile.get("button_min_size", Vector2i(220, 54))

	if pending_pick:
		_begin_region_pick_mode(event_data)
	else:
		_end_region_pick_mode()

	_update_active_target(event_data)

	for choice in event_data.get("choices", []):
		var button := Button.new()
		button.text = _display_text(String(choice.get("label", "Choose")), pending_pick, display_placeholder)
		button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		button.custom_minimum_size = Vector2(min_size.x, min_size.y)
		button.disabled = _awaiting_region_pick
		button.pressed.connect(_on_choice_selected.bind(choice))
		choices_container.add_child(button)

	_render_state()


# --- Regional pick mode ----------------------------------------------------

func _begin_region_pick_mode(event_data: Dictionary) -> void:
	_awaiting_region_pick = true
	var candidates: Array = event_data.get("_candidates", [])
	if region_map.has_method("set_selectable"):
		region_map.set_selectable(candidates)

	var prompt: String = String(event_data.get("target_prompt", "Pick a region on the map."))
	event_description_label.text = "%s\n\n> %s" % [
		String(event_data.get("description", "")),
		prompt
	]


func _end_region_pick_mode() -> void:
	_awaiting_region_pick = false
	if region_map.has_method("clear_selectable"):
		region_map.clear_selectable()


func _assign_event_icon(event_data: Dictionary) -> void:
	var id: String = String(event_data.get("id", ""))
	var path: String = String(EVENT_ICON_PATH_BY_ID.get(id, EVENT_ICON_FALLBACK_PATH))
	event_icon.texture = _safe_load_texture(path)
	event_icon.visible = event_icon.texture != null


func _display_text(source: String, clean_placeholders: bool, fallback: Dictionary) -> String:
	if not clean_placeholders:
		return source
	return event_director.format_text(source, fallback)


func _update_active_target(event_data: Dictionary) -> void:
	var target_id: String = String(event_data.get("_target_region_id", ""))
	if target_id == "" or not region_map.has_method("set_active_target"):
		if region_map.has_method("clear_active_target"):
			region_map.clear_active_target()
		return
	region_map.set_active_target(target_id)


# --- Signals ---------------------------------------------------------------

func _on_choice_selected(choice: Dictionary) -> void:
	if _awaiting_region_pick:
		# Guardrail: buttons should be disabled, but ignore stray clicks just in case.
		return

	var event_data: Dictionary = current_turn_events[current_event_index]
	var target_id: String = String(event_data.get("_target_region_id", ""))

	var global_effects: Dictionary = choice.get("effects", {})
	if not global_effects.is_empty():
		world_simulation.apply_effects(global_effects)

	var regional_effects: Dictionary = choice.get("effects_regional", {})
	if not regional_effects.is_empty() and target_id != "":
		world_simulation.apply_effects_regional(target_id, regional_effects)

	var adjacent_effects: Dictionary = choice.get("effects_adjacent", {})
	if not adjacent_effects.is_empty() and target_id != "":
		world_simulation.apply_effects_adjacent(target_id, adjacent_effects)

	_emit_control_loss_feedback()
	current_event_index += 1
	_render_current_event()


func _on_region_clicked(region_id: String) -> void:
	if not _awaiting_region_pick:
		return
	if current_turn_events.is_empty() or current_event_index >= current_turn_events.size():
		return

	var event_data: Dictionary = current_turn_events[current_event_index]
	if String(event_data.get("_kind", "")) != "player_chooses":
		return

	var region: Dictionary = world_simulation.region_grid.get_region(region_id)
	if region.is_empty():
		return

	# Bake the chosen region into the event so the rest of the flow behaves as a
	# regular regional_auto event from here on.
	event_data["_target_region_id"] = region_id
	event_data["_kind"] = "regional_auto"
	event_data["title"] = event_director.format_text(String(event_data.get("title", "")), region)
	event_data["description"] = event_director.format_text(String(event_data.get("description", "")), region)
	var rendered: Array = []
	for choice in event_data.get("choices", []):
		var c: Dictionary = choice.duplicate(true)
		c["label"] = event_director.format_text(String(c.get("label", "")), region)
		rendered.append(c)
	event_data["choices"] = rendered

	current_turn_events[current_event_index] = event_data
	_end_region_pick_mode()
	_render_current_event()


func _finalize_turn() -> void:
	world_simulation.apply_passive_turn_effects(meta_progression.get_run_modifiers())
	_emit_control_loss_feedback()
	world_simulation.advance_turn()
	_refresh_region_map()
	if region_map and region_map.has_method("trigger_turn_flash"):
		region_map.trigger_turn_flash(0.65)
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
		"regions": evaluation.get("regions", []),
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


func _control_snapshot_sync() -> void:
	_controlled_regions_prev.clear()
	for id in world_simulation.controlled_region_ids():
		_controlled_regions_prev[String(id)] = true


func _emit_control_loss_feedback() -> void:
	var current: Dictionary = {}
	for id in world_simulation.controlled_region_ids():
		current[String(id)] = true

	var lost: Array = []
	for id in _controlled_regions_prev.keys():
		if not current.has(id):
			lost.append(String(id))

	if not lost.is_empty():
		for rid in lost:
			if region_map.has_method("flash_region_loss"):
				region_map.flash_region_loss(rid)
		_play_loss_alert()
		var label: String = _region_name(lost[0])
		progress_label.text = "Region lost: %s%s" % [
			label,
			(" (+%d)" % (lost.size() - 1)) if lost.size() > 1 else ""
		]

	_controlled_regions_prev = current


func _region_name(region_id: String) -> String:
	var region: Dictionary = world_simulation.region_grid.get_region(region_id)
	return String(region.get("short", region_id))


func _setup_loss_audio() -> void:
	_loss_audio_player = AudioStreamPlayer.new()
	_loss_audio_stream = AudioStreamGenerator.new()
	_loss_audio_stream.mix_rate = 22050.0
	_loss_audio_stream.buffer_length = 0.25
	_loss_audio_player.stream = _loss_audio_stream
	_loss_audio_player.volume_db = LOSS_ALERT_VOLUME_DB
	add_child(_loss_audio_player)


func _play_loss_alert() -> void:
	if _loss_audio_player == null or _loss_audio_stream == null:
		return
	if not _loss_audio_player.playing:
		_loss_audio_player.play()
	var playback: AudioStreamGeneratorPlayback = _loss_audio_player.get_stream_playback()
	if playback == null:
		return

	var total_frames: int = min(3200, playback.get_frames_available())
	if total_frames <= 0:
		return
	var mix_rate: float = _loss_audio_stream.mix_rate
	for i in range(total_frames):
		var t: float = float(i) / float(total_frames)
		var freq: float = lerpf(560.0, 320.0, t)
		var phase: float = TAU * freq * (float(i) / mix_rate)
		var env: float = (1.0 - t) * (1.0 - t)
		var sample: float = sin(phase) * 0.28 * env
		playback.push_frame(Vector2(sample, sample))


func _safe_load_texture(path: String) -> Texture2D:
	if path.is_empty():
		return null
	if _event_icon_cache.has(path):
		return _event_icon_cache[path]
	if not ResourceLoader.exists(path):
		_event_icon_cache[path] = null
		return null
	var res: Resource = ResourceLoader.load(path)
	var tex: Texture2D = res as Texture2D
	_event_icon_cache[path] = tex
	return tex


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
