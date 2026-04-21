extends Control

const MetaProgressionClass = preload("res://scripts/systems/meta_progression.gd")
const SessionBridgeClass = preload("res://scripts/systems/session_bridge.gd")
const PlatformProfileClass = preload("res://scripts/systems/platform_profile.gd")

@onready var summary_label: Label = $Margin/VBox/SummaryLabel
@onready var credits_label: Label = $Margin/VBox/Header/CreditsBadge/CreditsLabel
@onready var techs_container: VBoxContainer = $Margin/VBox/TechsPanel/TechsList
@onready var play_again_button: Button = $Margin/VBox/Actions/PlayAgainButton
@onready var main_menu_button: Button = $Margin/VBox/Actions/MainMenuButton

const BADGE_UNLOCKED_PATH: String = "res://assets/art/icons/badge_unlocked.png"
const BADGE_AFFORDABLE_PATH: String = "res://assets/art/icons/badge_affordable.png"
const BADGE_LOCKED_PATH: String = "res://assets/art/icons/badge_locked.png"

var meta_progression: MetaProgression
var tech_data: Array = []
var platform_profile: PlatformProfile


func _ready() -> void:
	platform_profile = PlatformProfileClass.new()
	tech_data = _load_json_array("res://data/techs.json")

	meta_progression = MetaProgressionClass.new()
	meta_progression.initialize(tech_data)

	play_again_button.pressed.connect(_on_play_again_pressed)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

	_apply_platform_profile()
	_render()


func _apply_platform_profile() -> void:
	var profile: Dictionary = platform_profile.current_profile()
	var min_size: Vector2i = profile.get("button_min_size", Vector2i(220, 54))
	play_again_button.custom_minimum_size = Vector2(min_size.x, min_size.y)
	main_menu_button.custom_minimum_size = Vector2(min_size.x, min_size.y)


func _render() -> void:
	var run_result: Dictionary = SessionBridgeClass.load_run_result()
	if run_result.is_empty():
		summary_label.text = "No recent run. Start a run to earn credits and unlock upgrades."
	else:
		var outcome: String = String(run_result.get("outcome", "timeout"))
		var gained: int = int(run_result.get("credits_gained", 0))
		var chapter_completed: bool = bool(run_result.get("chapter_goal_completed", false))
		var chapter_line: String = "Chapter objective: not completed"
		if chapter_completed:
			chapter_line = "Chapter objective: completed"
		summary_label.text = "Last run outcome: %s\nCredits gained: %d\n%s" % [outcome, gained, chapter_line]

	credits_label.text = "Permanent credits: %d" % meta_progression.credits

	for child in techs_container.get_children():
		child.queue_free()

	for tech in tech_data:
		var tech_id: String = String(tech.get("id", ""))
		var tech_name: String = String(tech.get("name", "Unknown"))
		var tech_description: String = String(tech.get("description", ""))
		var tech_cost: int = int(tech.get("cost", 999))
		var is_unlocked: bool = meta_progression.unlocked_techs.has(tech_id)
		var affordable: bool = meta_progression.credits >= tech_cost

		# Card: [left status badge][title + description][cost pill][action]
		var card := PanelContainer.new()
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var row := HBoxContainer.new()
		row.add_theme_constant_override("separation", 14)
		card.add_child(row)

		var badge := TextureRect.new()
		badge.custom_minimum_size = Vector2(32, 32)
		badge.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		badge.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		badge.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		var badge_path: String = BADGE_UNLOCKED_PATH if is_unlocked else (
			BADGE_AFFORDABLE_PATH if affordable else BADGE_LOCKED_PATH)
		if ResourceLoader.exists(badge_path):
			badge.texture = load(badge_path)
		row.add_child(badge)

		var info := VBoxContainer.new()
		info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		info.add_theme_constant_override("separation", 2)
		row.add_child(info)

		var name_label := Label.new()
		name_label.text = tech_name
		name_label.add_theme_font_size_override("font_size", 18)
		info.add_child(name_label)

		if tech_description != "":
			var desc_label := Label.new()
			desc_label.text = tech_description
			desc_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			desc_label.add_theme_font_size_override("font_size", 13)
			desc_label.modulate = Color(1, 1, 1, 0.82)
			info.add_child(desc_label)

		var cost_label := Label.new()
		cost_label.text = "%d cr" % tech_cost
		cost_label.add_theme_font_size_override("font_size", 16)
		cost_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		cost_label.add_theme_color_override("font_color",
			Color(0.780, 0.604, 0.235, 1.0) if (is_unlocked or affordable)
			else Color(0.362, 0.271, 0.294, 1.0))
		row.add_child(cost_label)

		var button := Button.new()
		button.text = "UNLOCKED" if is_unlocked else "Unlock"
		button.disabled = is_unlocked
		button.custom_minimum_size = Vector2(120, 40)
		if not is_unlocked:
			button.disabled = not affordable
			button.pressed.connect(_on_unlock_pressed.bind(tech_id))
		row.add_child(button)

		techs_container.add_child(card)


func _on_unlock_pressed(tech_id: String) -> void:
	if meta_progression.unlock_tech(tech_id):
		_render()


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/RunScene.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")


func _load_json_array(path: String) -> Array:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return []
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_ARRAY:
		return []
	return parsed
