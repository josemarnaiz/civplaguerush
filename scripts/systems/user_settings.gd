class_name UserSettings
extends RefCounted

const SAVE_PATH := "user://settings.json"
const LOCALE_EN := "en"
const LOCALE_ES := "es"


static func load_settings() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		return { "locale": LOCALE_EN }
	var f: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if f == null:
		return { "locale": LOCALE_EN }
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return { "locale": LOCALE_EN }
	var out: Dictionary = parsed
	if String(out.get("locale", "")) == "":
		out["locale"] = LOCALE_EN
	return out


static func save_settings(data: Dictionary) -> void:
	var f: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if f == null:
		return
	f.store_string(JSON.stringify(data, "\t"))


static func get_locale() -> String:
	var settings: Dictionary = load_settings()
	var locale: String = String(settings.get("locale", LOCALE_EN))
	return LOCALE_ES if locale == LOCALE_ES else LOCALE_EN


static func set_locale(locale: String) -> void:
	var settings: Dictionary = load_settings()
	settings["locale"] = LOCALE_ES if locale == LOCALE_ES else LOCALE_EN
	save_settings(settings)


static func toggle_locale() -> String:
	var next: String = LOCALE_ES if get_locale() == LOCALE_EN else LOCALE_EN
	set_locale(next)
	return next
