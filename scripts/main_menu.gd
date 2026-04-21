extends Control

const UserSettingsClass = preload("res://scripts/systems/user_settings.gd")

# Title is now a TextureRect with the painted logo; no runtime text assignment.
@onready var subtitle_label: Label = $Margin/VBox/SubTitle
@onready var chapter_intro_label: Label = $Margin/VBox/ChapterPanel/ChapterMargin/ChapterIntro
@onready var start_button: Button = $Margin/VBox/Actions/StartRunButton
@onready var meta_button: Button = $Margin/VBox/Actions/MetaButton
@onready var quit_button: Button = $Margin/VBox/Actions/QuitButton
@onready var title_texture: TextureRect = $Margin/VBox/TitleRow/Title

var _title_time: float = 0.0
var _locale: String = "en"
var _lang_button: Button = null


func _ready() -> void:
	_locale = UserSettingsClass.get_locale()
	_ensure_language_button()
	_apply_localized_labels()

	start_button.pressed.connect(_on_start_run_pressed)
	meta_button.pressed.connect(_on_meta_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	if is_instance_valid(title_texture):
		title_texture.pivot_offset = title_texture.size * 0.5
		title_texture.resized.connect(func(): title_texture.pivot_offset = title_texture.size * 0.5)


func _process(delta: float) -> void:
	if not is_instance_valid(title_texture):
		return
	_title_time += delta
	# Breathing pulse: slow sine on scale and modulate so the logo feels alive.
	var breath: float = sin(_title_time * 1.4)
	var scale_amp: float = 0.012
	var glow_amp: float = 0.08
	title_texture.scale = Vector2.ONE * (1.0 + breath * scale_amp)
	var warm: Color = Color(1.0, 0.97 + glow_amp * breath * 0.3, 0.92 + glow_amp * breath * 0.6, 1.0)
	title_texture.modulate = warm


func _chapter_intro_text() -> String:
	var chapter_data: Dictionary = _active_chapter_data()
	var title: String = _chapter_text(chapter_data, "title")
	var intro: String = _chapter_text(chapter_data, "intro")
	return "%s\n\n%s" % [title, intro]


func _active_chapter_data() -> Dictionary:
	var chapter_paths: Array[String] = [
		"res://data/campaign_ch1.json",
		"res://data/campaign_ch2.json",
		"res://data/campaign_ch3.json"
	]
	var first: Dictionary = {}
	var mp = preload("res://scripts/systems/meta_progression.gd").new()
	mp.initialize([])
	for p in chapter_paths:
		var data: Dictionary = _load_json_dict(p)
		if data.is_empty():
			continue
		if first.is_empty():
			first = data
		var cid: String = String(data.get("chapter_id", ""))
		if cid == "" or String(mp.chapter_status.get(cid, "")) != "completed":
			return data
	return first


func _chapter_text(chapter_data: Dictionary, key: String) -> String:
	if _locale == "es":
		var es_key: String = "%s_es" % key
		if chapter_data.has(es_key):
			return String(chapter_data.get(es_key, ""))
	return String(chapter_data.get(key, ""))


func _apply_localized_labels() -> void:
	var es: bool = _locale == "es"
	subtitle_label.text = "Partidas de 8-12 minutos, progresion permanente y campana por capitulos." if es else "8-12 minute runs, permanent progression, chapter-driven campaign."
	chapter_intro_label.text = _chapter_intro_text()
	start_button.text = "Iniciar partida" if es else "Start Run"
	meta_button.text = "Archivo Meta" if es else "Meta Hub"
	quit_button.text = "Salir" if es else "Quit"
	if is_instance_valid(_lang_button):
		_lang_button.text = "Idioma: ES" if es else "Language: EN"


func _ensure_language_button() -> void:
	if is_instance_valid(_lang_button):
		return
	_lang_button = Button.new()
	_lang_button.custom_minimum_size = Vector2(180, 42)
	_lang_button.pressed.connect(_on_toggle_language_pressed)
	$Margin/VBox/Actions.add_child(_lang_button)


func _on_toggle_language_pressed() -> void:
	_locale = UserSettingsClass.toggle_locale()
	_apply_localized_labels()


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
