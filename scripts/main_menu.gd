extends Control

# Title is now a TextureRect with the painted logo; no runtime text assignment.
@onready var subtitle_label: Label = $Margin/VBox/SubTitle
@onready var chapter_intro_label: Label = $Margin/VBox/ChapterPanel/ChapterMargin/ChapterIntro
@onready var start_button: Button = $Margin/VBox/Actions/StartRunButton
@onready var meta_button: Button = $Margin/VBox/Actions/MetaButton
@onready var quit_button: Button = $Margin/VBox/Actions/QuitButton


func _ready() -> void:
	subtitle_label.text = "8-12 minute runs, permanent progression, chapter-driven campaign."
	chapter_intro_label.text = _chapter_intro_text()

	start_button.pressed.connect(_on_start_run_pressed)
	meta_button.pressed.connect(_on_meta_pressed)
	quit_button.pressed.connect(_on_quit_pressed)


func _chapter_intro_text() -> String:
	var chapter_data: Dictionary = _load_json_dict("res://data/campaign_ch1.json")
	var title: String = String(chapter_data.get("title", "Chapter 1"))
	var intro: String = String(chapter_data.get("intro", ""))
	return "%s\n\n%s" % [title, intro]


func _on_start_run_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/RunScene.tscn")


func _on_meta_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MetaHub.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _load_json_dict(path: String) -> Dictionary:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return {}
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return {}
	return parsed
