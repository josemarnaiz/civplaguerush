extends Control

const MetaProgressionClass = preload("res://scripts/systems/meta_progression.gd")
const SessionBridgeClass = preload("res://scripts/systems/session_bridge.gd")
const PlatformProfileClass = preload("res://scripts/systems/platform_profile.gd")

@onready var summary_label: Label = $Margin/VBox/SummaryLabel
@onready var credits_label: Label = $Margin/VBox/CreditsLabel
@onready var techs_container: VBoxContainer = $Margin/VBox/TechsPanel/TechsList
@onready var play_again_button: Button = $Margin/VBox/Actions/PlayAgainButton
@onready var main_menu_button: Button = $Margin/VBox/Actions/MainMenuButton

var meta_progression
var tech_data: Array = []
var platform_profile


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

		var line := HBoxContainer.new()
		line.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var label := Label.new()
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		label.text = "%s (%d) - %s" % [tech_name, tech_cost, tech_description]
		line.add_child(label)

		var button := Button.new()
		button.text = "Unlocked" if is_unlocked else "Unlock"
		button.disabled = is_unlocked
		if not is_unlocked:
			button.disabled = meta_progression.credits < tech_cost
			button.pressed.connect(_on_unlock_pressed.bind(tech_id))
		line.add_child(button)

		techs_container.add_child(line)


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
