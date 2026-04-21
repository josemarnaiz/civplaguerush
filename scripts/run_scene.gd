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
@onready var stat_crisis_row: HBoxContainer = $Margin/VBox/StatePanel/StatsBox/Crisis
@onready var stat_control: Label = $Margin/VBox/StatePanel/StatsBox/Control/Value
@onready var event_panel: PanelContainer = $Margin/VBox/EventPanel
@onready var event_row: HBoxContainer = $Margin/VBox/EventPanel/EventRow
@onready var advisor_portrait: TextureRect = $Margin/VBox/EventPanel/EventRow/AdvisorSlot/AdvisorPortrait
@onready var event_icon: TextureRect = $Margin/VBox/EventPanel/EventRow/EventVBox/EventHeader/EventIcon
@onready var event_title_label: Label = $Margin/VBox/EventPanel/EventRow/EventVBox/EventHeader/EventTitle
@onready var event_description_label: Label = $Margin/VBox/EventPanel/EventRow/EventVBox/EventDescription
@onready var choices_container: VBoxContainer = $Margin/VBox/EventPanel/EventRow/EventVBox/Choices

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

# Maps event id -> advisor portrait that "narrates" this event. The advisor
# thematically matches the event category (plague -> plaguewright, etc.) so
# the council feels like a persistent cast reacting to the world.
const ADVISOR_PATH_BY_ID: Dictionary = {
	"food_shortage": "res://assets/art/advisors/advisor_architect.png",
	"border_uprising": "res://assets/art/advisors/advisor_marshal.png",
	"info_leak": "res://assets/art/advisors/advisor_shadow.png",
	"pandemic_wave": "res://assets/art/advisors/advisor_plaguewright.png",
	"golden_opportunity": "res://assets/art/advisors/advisor_chancellor.png",
	"outbreak_focus": "res://assets/art/advisors/advisor_plaguewright.png",
	"frontier_uprising": "res://assets/art/advisors/advisor_marshal.png",
	"defector_cell": "res://assets/art/advisors/advisor_shadow.png",
	"relief_mission": "res://assets/art/advisors/advisor_architect.png",
	"sabotage_strike": "res://assets/art/advisors/advisor_shadow.png",
	"cure_trial": "res://assets/art/advisors/advisor_arcanist.png",
	"mass_migration": "res://assets/art/advisors/advisor_chancellor.png",
}
const ADVISOR_FALLBACK_PATH: String = "res://assets/art/advisors/advisor_chancellor.png"
@onready var progress_label: Label = $Margin/VBox/Footer/ProgressLabel
@onready var back_button: Button = $Margin/VBox/Footer/BackButton
@onready var run_end_overlay: Control = $RunEndOverlay
var _floater_layer: CanvasLayer = null

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
	# Show the turn ribbon after the state is rendered so the new turn number
	# is already on the HUD when the ribbon reads it. Skip on the very first
	# render (turn 0) because the player just clicked Start Run.
	if world_simulation.turn_index > 0:
		_show_turn_ribbon()


# Slides a gold ribbon across the top of the screen that reads "Turn N / M",
# fading out after a beat. Purely decorative — does not block input.
func _show_turn_ribbon() -> void:
	var layer: CanvasLayer = _floater_layer
	if layer == null:
		layer = CanvasLayer.new()
		layer.layer = 50
		add_child(layer)
		_floater_layer = layer

	var ribbon := PanelContainer.new()
	ribbon.name = "TurnRibbon"
	var bg := StyleBoxFlat.new()
	bg.bg_color = Color(0.059, 0.039, 0.055, 0.92)
	bg.border_color = Color(0.910, 0.753, 0.407, 1.0)  # O4 gold
	bg.set_border_width_all(0)
	bg.border_width_top = 2
	bg.border_width_bottom = 2
	bg.content_margin_left = 48
	bg.content_margin_right = 48
	bg.content_margin_top = 10
	bg.content_margin_bottom = 10
	ribbon.add_theme_stylebox_override("panel", bg)

	var lbl := Label.new()
	lbl.text = "TURN  %d  /  %d" % [world_simulation.turn_index + 1, world_simulation.turns_total]
	lbl.add_theme_font_size_override("font_size", 28)
	lbl.add_theme_color_override("font_color", Color(0.910, 0.753, 0.407, 1.0))
	lbl.add_theme_color_override("font_outline_color", Color(0.059, 0.039, 0.055, 1.0))
	lbl.add_theme_constant_override("outline_size", 6)
	lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	ribbon.add_child(lbl)

	layer.add_child(ribbon)
	# Fit the container to the label.
	ribbon.force_update_transform()
	# Position from screen: entry from the left edge, target at horizontal centre
	# one-fifth down from the top; exit off the right edge.
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	await get_tree().process_frame
	var ribbon_size: Vector2 = ribbon.size
	var target_y: float = viewport_size.y * 0.18
	ribbon.position = Vector2(-ribbon_size.x, target_y)
	var centre_x: float = (viewport_size.x - ribbon_size.x) * 0.5
	var exit_x: float = viewport_size.x + 20.0

	var tw := create_tween()
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(ribbon, "position:x", centre_x, 0.35)
	tw.tween_interval(1.05)
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tw.tween_property(ribbon, "position:x", exit_x, 0.35)
	tw.tween_callback(ribbon.queue_free)


func _render_state() -> void:
	turn_label.text = "Turn %d / %d" % [world_simulation.turn_index + 1, world_simulation.turns_total]
	var s: Dictionary = world_simulation.world_state
	var target: int = int(config.get("win_conditions", {}).get(
		"target_control_regions", WorldSimulationClass.DEFAULT_TARGET_CONTROL_REGIONS))

	_tween_stat_number(stat_stability, int(s.get("stability", 0)))
	_tween_stat_number(stat_influence, int(s.get("influence", 0)))
	_tween_stat_number(stat_resources, int(s.get("resources", 0)))
	_tween_stat_number(stat_crisis, int(s.get("crisis", 0)))
	_tween_stat_number(stat_control, int(s.get("control_regions", 0)), target)

	# Tint crisis value red when it's climbing to warn the player.
	var crisis: int = int(s.get("crisis", 0))
	var crisis_col: Color = Color(0.910, 0.831, 0.706, 1.0) # C4 cream
	if crisis >= 50:
		crisis_col = Color(0.851, 0.329, 0.306, 1.0)        # R4 wound red
	elif crisis >= 30:
		crisis_col = Color(0.780, 0.604, 0.235, 1.0)        # O3 signature gold
	stat_crisis.add_theme_color_override("font_color", crisis_col)
	# Above the alarm threshold we pulse the whole Crisis row's modulate so
	# the player feels the danger even peripherally. Below threshold, we let
	# any lingering alarm tween decay back to 1.0.
	_update_crisis_alarm(crisis)

	progress_label.text = "Decision %d / %d this turn" % [current_event_index + 1, max(1, decisions_this_turn)]
	_refresh_region_map()


# Tween helper: counts from the label's current numeric value up/down to the
# new value over 0.35 s with cubic-out easing. Uses an int interpolation so the
# label never shows fractional values. Supports "N / M" format via max_value.
func _tween_stat_number(label: Label, target_value: int, max_value: int = -1) -> void:
	if label == null:
		return
	# Godot 4.6 logs an error from get_meta even when a default is provided and
	# the meta is unset, so we gate on has_meta to keep _render_state quiet.
	if label.has_meta("count_tw"):
		var existing: Tween = label.get_meta("count_tw")
		if existing is Tween and existing.is_valid():
			existing.kill()
	var current_text: String = label.text
	var current_value: int = _parse_leading_int(current_text)
	# Nothing to animate.
	if current_value == target_value:
		_write_stat_text(label, target_value, max_value)
		return
	var duration: float = 0.35 if absi(target_value - current_value) >= 3 else 0.18
	var tw := create_tween()
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	# method_bind lambda that writes the lerped integer into the label each tick.
	tw.tween_method(
		func(v: float) -> void:
			_write_stat_text(label, int(round(v)), max_value),
		float(current_value), float(target_value), duration
	)
	label.set_meta("count_tw", tw)


func _write_stat_text(label: Label, value: int, max_value: int) -> void:
	if max_value >= 0:
		label.text = "%d / %d" % [value, max_value]
	else:
		label.text = str(value)


func _parse_leading_int(s: String) -> int:
	var out: String = ""
	for i in range(s.length()):
		var ch: String = s[i]
		if ch == "-" and out == "":
			out += ch
		elif ch >= "0" and ch <= "9":
			out += ch
		else:
			break
	if out == "" or out == "-":
		return 0
	return int(out)


func _refresh_region_map() -> void:
	if region_map == null:
		return
	if region_map.has_method("refresh"):
		region_map.refresh(world_simulation.regions_snapshot())


# When crisis crosses 50 we pulse the whole row so the player can't miss it;
# the existing Value label colour ramp already handles <30 and 30-49.
# We keep a single sticky tween on the row: start it on rising edge, stop and
# reset modulate when crisis drops back under threshold.
const _CRISIS_ALARM_THRESHOLD: int = 50
var _crisis_alarm_active: bool = false

func _update_crisis_alarm(crisis: int) -> void:
	if not is_instance_valid(stat_crisis_row):
		return
	var should_alarm: bool = crisis >= _CRISIS_ALARM_THRESHOLD
	if should_alarm and not _crisis_alarm_active:
		_crisis_alarm_active = true
		var tw := create_tween()
		tw.set_loops()
		tw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tw.tween_property(stat_crisis_row, "modulate", Color(1.15, 0.80, 0.80, 1.0), 0.55)
		tw.tween_property(stat_crisis_row, "modulate", Color(1.00, 1.00, 1.00, 1.0), 0.55)
		stat_crisis_row.set_meta("alarm_tw", tw)
	elif not should_alarm and _crisis_alarm_active:
		_crisis_alarm_active = false
		if stat_crisis_row.has_meta("alarm_tw"):
			var existing: Tween = stat_crisis_row.get_meta("alarm_tw")
			if existing is Tween and existing.is_valid():
				existing.kill()
		var cooldown := create_tween()
		cooldown.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		cooldown.tween_property(stat_crisis_row, "modulate", Color(1, 1, 1, 1), 0.25)


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
		# Tell the VBox to honour our min size and keep each row independent,
		# so no stray measurement collapses rows onto each other (see BUG-001).
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.clip_text = false
		button.pressed.connect(_on_choice_selected.bind(choice))
		# Attach a tag chip on the left of the text so players can read the
		# "flavour" of each option at a glance (force/diplomacy/science/etc.).
		var tag: String = String(choice.get("tag", "")) if choice.has("tag") else _infer_choice_tag(choice)
		_apply_choice_chip(button, tag)
		_wire_choice_hover(button)
		choices_container.add_child(button)

	# Force the VBoxContainer to re-sort on this same frame. Without this, a
	# late `modulate` assignment could theoretically land before the container
	# positions each child, which would stack all buttons at y=0 (BUG-001).
	choices_container.queue_sort()

	_render_state()
	_animate_event_reveal()


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
	# Insert a bold gold hint banner at the top of the choices stack so the
	# player never reads the disabled buttons as "UI is broken". Removed by
	# _end_region_pick_mode (via the blanket choices_container clear on next
	# render) or the node is free'd when we leave the mode.
	var hint := Label.new()
	hint.name = "RegionPickHint"
	hint.text = "[!] " + prompt
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	hint.add_theme_font_size_override("font_size", 18)
	hint.add_theme_color_override("font_color", Color(0.910, 0.753, 0.407, 1.0))  # O4 gold
	hint.add_theme_color_override("font_outline_color", Color(0.059, 0.039, 0.055, 1.0))
	hint.add_theme_constant_override("outline_size", 4)
	hint.modulate.a = 0.0
	choices_container.add_child(hint)
	choices_container.move_child(hint, 0)
	var tw := create_tween()
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(hint, "modulate:a", 1.0, 0.28)
	# Pulse the hint alpha between 1.0 and 0.72 forever (3 Hz breath) so it
	# reads as "active input surface elsewhere on screen".
	_start_hint_breath(hint)


func _start_hint_breath(hint: Label) -> void:
	if not is_instance_valid(hint):
		return
	var bw := create_tween()
	bw.set_loops()
	bw.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	bw.tween_property(hint, "modulate:a", 0.72, 0.6)
	bw.tween_property(hint, "modulate:a", 1.00, 0.6)
	hint.set_meta("breath_tw", bw)


func _end_region_pick_mode() -> void:
	_awaiting_region_pick = false
	if region_map.has_method("clear_selectable"):
		region_map.clear_selectable()


func _assign_event_icon(event_data: Dictionary) -> void:
	var id: String = String(event_data.get("id", ""))
	var icon_path: String = String(EVENT_ICON_PATH_BY_ID.get(id, EVENT_ICON_FALLBACK_PATH))
	event_icon.texture = _safe_load_texture(icon_path)
	event_icon.visible = event_icon.texture != null

	var advisor_path: String = String(ADVISOR_PATH_BY_ID.get(id, ADVISOR_FALLBACK_PATH))
	advisor_portrait.texture = _safe_load_texture(advisor_path)
	advisor_portrait.visible = advisor_portrait.texture != null


# --- Event reveal animation ------------------------------------------------
# When a new event shows up, slide the whole panel in from the right by a few
# pixels + fade. Advisor pops with a small scale punch. Choice buttons stagger
# their fade-in so the player's eye tracks top-to-bottom.
func _animate_event_reveal() -> void:
	if not is_inside_tree():
		return
	# Kill any ongoing animation tweens so we don't stack them.
	if event_row:
		event_row.set_meta("_event_tween_generation", int(event_row.get_meta("_event_tween_generation", 0)) + 1)
		event_row.modulate = Color(1, 1, 1, 0.0)
		event_row.position = Vector2(24.0, 0.0)
		var tw: Tween = create_tween()
		tw.set_parallel(true)
		tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tw.tween_property(event_row, "modulate:a", 1.0, 0.28)
		tw.tween_property(event_row, "position:x", 0.0, 0.34)

	if advisor_portrait and advisor_portrait.visible:
		advisor_portrait.pivot_offset = advisor_portrait.size * 0.5
		advisor_portrait.scale = Vector2(0.86, 0.86)
		var pt: Tween = create_tween()
		pt.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		pt.tween_property(advisor_portrait, "scale", Vector2.ONE, 0.42)

	# Stagger the choice buttons (they were just rebuilt in _render_current_event).
	# Only tween modulate — touching `position.y` fights the VBoxContainer layout
	# and collapses every button to y=0 once the tween lands.
	if choices_container:
		var i: int = 0
		for child in choices_container.get_children():
			if child is Control:
				var btn: Control = child
				btn.modulate = Color(1, 1, 1, 0.0)
				var delay: float = 0.10 + 0.08 * float(i)
				var ct: Tween = create_tween()
				ct.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				ct.tween_property(btn, "modulate:a", 1.0, 0.28).set_delay(delay)
				i += 1


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

	# Snapshot world_state before applying effects so we can diff it afterwards
	# and surface floating +/- numbers over the corresponding HUD stat.
	var pre_state: Dictionary = world_simulation.world_state.duplicate(true)

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
	_emit_stat_floaters(pre_state, world_simulation.world_state)
	current_event_index += 1
	_render_current_event()


# --- Choice tag chips -----------------------------------------------------
# Small 24x24 emblem + left-inset padding so every choice carries a readable
# archetype badge: force, diplomacy, science, sacrifice, economy. When an
# event data file doesn't ship an explicit `tag`, we heuristically infer one
# from the effects payload so legacy events light up for free.

const CHOICE_CHIP_PATH_BY_TAG: Dictionary = {
	"force": "res://assets/art/icons/tag_force.png",
	"diplomacy": "res://assets/art/icons/tag_diplomacy.png",
	"science": "res://assets/art/icons/tag_science.png",
	"sacrifice": "res://assets/art/icons/tag_sacrifice.png",
	"economy": "res://assets/art/icons/tag_economy.png",
}


func _infer_choice_tag(choice: Dictionary) -> String:
	var effects: Dictionary = choice.get("effects", {})
	var crisis_d: int = int(effects.get("crisis", 0))
	var stability_d: int = int(effects.get("stability", 0))
	var influence_d: int = int(effects.get("influence", 0))
	var resources_d: int = int(effects.get("resources", 0))
	var control_d: int = int(effects.get("control_regions", 0))

	# Force: aggressive — crisis rises hard OR takes control_regions aggressively.
	if crisis_d >= 5 or control_d >= 1 and stability_d <= 0:
		return "force"
	# Sacrifice: explicit self-wound — stability/control crashes for payoff.
	if stability_d <= -4 or control_d <= -1:
		return "sacrifice"
	# Science: heavy resource investment that cools crisis.
	if resources_d <= -6 and crisis_d <= -3:
		return "science"
	# Diplomacy: stability or influence gain without a crisis bump.
	if (stability_d >= 4 or influence_d >= 4) and crisis_d <= 0:
		return "diplomacy"
	# Economy: pure resource move (spend to calm, or harvest).
	if abs(resources_d) >= 4:
		return "economy"
	# Default: diplomacy tends to be the soft-default council action.
	return "diplomacy"


func _apply_choice_chip(button: Button, tag: String) -> void:
	if tag == "" or not CHOICE_CHIP_PATH_BY_TAG.has(tag):
		return
	var tex: Texture2D = _safe_load_texture(String(CHOICE_CHIP_PATH_BY_TAG[tag]))
	if tex == null:
		return
	button.icon = tex
	button.expand_icon = false
	# Nudge the text right so the icon doesn't collide with the label.
	button.add_theme_constant_override("icon_max_width", 24)
	button.add_theme_constant_override("h_separation", 14)
	button.alignment = HORIZONTAL_ALIGNMENT_CENTER


# Warm, subtle hover breathing for choice buttons. Keeps the UI feeling
# reactive without jumping around the layout — only modulate is animated.
func _wire_choice_hover(button: Button) -> void:
	button.pivot_offset = button.size * 0.5
	button.resized.connect(func(): button.pivot_offset = button.size * 0.5)
	button.mouse_entered.connect(func(): _hover_choice(button, true))
	button.mouse_exited.connect(func(): _hover_choice(button, false))


func _hover_choice(button: Button, entering: bool) -> void:
	if not is_instance_valid(button):
		return
	if button.has_meta("hover_tw"):
		var kill: Tween = button.get_meta("hover_tw")
		if kill is Tween and kill.is_valid():
			kill.kill()
	var tw := create_tween()
	tw.set_parallel(true)
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	var target_mod: Color = Color(1.08, 1.04, 0.96, 1.0) if entering else Color(1, 1, 1, 1)
	tw.tween_property(button, "modulate", target_mod, 0.18)
	button.set_meta("hover_tw", tw)


# --- Stat delta floaters ---------------------------------------------------
# Pops a short "+5" / "-3" label above each HUD stat whenever a decision
# changes it. Colour-coded so crisis-up reads as bad and the rest read
# naturally: positive green, negative red. Labels float up + fade in 0.85s.

func _emit_stat_floaters(pre_state: Dictionary, post_state: Dictionary) -> void:
	var anchors: Dictionary = {
		"stability": stat_stability,
		"influence": stat_influence,
		"resources": stat_resources,
		"crisis": stat_crisis,
		"control_regions": stat_control,
	}
	for key in anchors.keys():
		var pre: int = int(pre_state.get(key, 0))
		var post: int = int(post_state.get(key, 0))
		var delta: int = post - pre
		if delta == 0:
			continue
		var anchor: Control = anchors[key]
		if anchor == null or not anchor.is_inside_tree():
			continue
		var anchor_center: Vector2 = anchor.get_global_position() + anchor.size * 0.5
		_spawn_stat_floater(anchor_center, String(key), delta)


func _spawn_stat_floater(center: Vector2, key: String, delta: int) -> void:
	var sign_str: String = "+" if delta > 0 else ""
	var text: String = "%s%d" % [sign_str, delta]

	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_font_size_override("font_size", 20)
	# Dark outline so it reads on both cream and dark panels.
	lbl.add_theme_color_override("font_outline_color", Color(0.059, 0.039, 0.055, 1.0))
	lbl.add_theme_constant_override("outline_size", 4)

	# Positive deltas are green, negative red. Crisis is inverted (going up is bad).
	var is_good: bool = delta > 0
	if key == "crisis":
		is_good = delta < 0
	var good_color := Color(0.659, 0.737, 0.349, 1.0)   # G3 — toxic green
	var bad_color := Color(0.851, 0.329, 0.306, 1.0)    # R4 — wound red
	lbl.add_theme_color_override("font_color", good_color if is_good else bad_color)

	# Center the label on the anchor; Label pivots at its top-left so we offset.
	lbl.position = center - Vector2(20.0, 30.0)
	# Parent into a CanvasLayer so the floater always draws on top of the HUD,
	# panels, and the run-end overlay backdrop.
	if _floater_layer == null:
		_floater_layer = CanvasLayer.new()
		_floater_layer.layer = 50
		add_child(_floater_layer)
	_floater_layer.add_child(lbl)

	var dur: float = 1.10
	var fade_delay: float = 0.55
	var fade_len: float = dur - fade_delay
	var tw := create_tween()
	tw.set_parallel(true)
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(lbl, "position:y", lbl.position.y - 42.0, dur)
	tw.tween_property(lbl, "modulate:a", 0.0, fade_len).set_delay(fade_delay)
	# queue_free after the longest parallel tween finishes.
	tw.chain().tween_callback(lbl.queue_free)


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

	# Refresh the HUD with the post-passive, post-advance state BEFORE we
	# evaluate outcome so the numbers the player reads on-screen match the
	# numbers the simulation is judging the run against (see BUG-006).
	_render_state()

	var evaluation: Dictionary = world_simulation.evaluate_outcome()
	var outcome: String = String(evaluation.get("outcome", "ongoing"))

	# One-line trace so any spurious end-of-run (see BUG-002) leaves forensic
	# evidence in the logs. Cheap, emitted exactly once per turn transition.
	var ev_state: Dictionary = evaluation.get("state", {})
	print("[RunScene] turn=%d/%d outcome=%s stab=%d inf=%d res=%d crisis=%d control=%d" % [
		world_simulation.turn_index,
		world_simulation.turns_total,
		outcome,
		int(ev_state.get("stability", 0)),
		int(ev_state.get("influence", 0)),
		int(ev_state.get("resources", 0)),
		int(ev_state.get("crisis", 0)),
		int(ev_state.get("control_regions", 0)),
	])

	if outcome == "ongoing":
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

	# Show the outcome overlay (Victory/Defeat/Timeout) before handing off to
	# MetaHub. The overlay waits for user input or auto-advances after its
	# internal hold, then signals `finished` so we can change scene.
	# `WorldSimulation.evaluate_outcome` emits "win/loss/timeout/ongoing" but the
	# overlay dictionaries are keyed by "victory/chapter_cleared/defeat/loss/..."
	# so translate here to keep the mood-specific title+subtitle+portrait wired.
	var raw_outcome: String = String(run_result.get("outcome", "ongoing"))
	var overlay_outcome: String = _overlay_outcome_for(raw_outcome, chapter_goal_completed)
	if run_end_overlay and run_end_overlay.has_method("show_outcome"):
		if not run_end_overlay.finished.is_connected(_on_run_end_finished):
			run_end_overlay.finished.connect(_on_run_end_finished, CONNECT_ONE_SHOT)
		run_end_overlay.show_outcome(overlay_outcome)
	else:
		get_tree().change_scene_to_file("res://scenes/MetaHub.tscn")


# Translates a WorldSimulation outcome ("win/loss/timeout/ongoing") into the
# mood key expected by RunEndOverlay ("victory/chapter_cleared/defeat/timeout/
# ongoing"). Keeping the translation here means the sim stays domain-pure and
# the overlay keeps its narrative vocabulary.
func _overlay_outcome_for(raw_outcome: String, chapter_goal_completed: bool) -> String:
	match raw_outcome:
		"win":
			return "chapter_cleared" if chapter_goal_completed else "victory"
		"loss":
			return "defeat"
		_:
			return raw_outcome


func _on_run_end_finished() -> void:
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
