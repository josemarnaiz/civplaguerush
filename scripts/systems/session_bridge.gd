class_name SessionBridge
extends RefCounted

const RUN_RESULT_PATH := "user://last_run_result.json"


static func save_run_result(data: Dictionary) -> void:
	var file: FileAccess = FileAccess.open(RUN_RESULT_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(data, "\t"))


static func load_run_result() -> Dictionary:
	if not FileAccess.file_exists(RUN_RESULT_PATH):
		return {}
	var file: FileAccess = FileAccess.open(RUN_RESULT_PATH, FileAccess.READ)
	if file == null:
		return {}
	var parsed: Variant = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY:
		return {}
	return parsed
