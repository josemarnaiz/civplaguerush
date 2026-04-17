class_name MetricsTracker
extends RefCounted

const METRICS_PATH := "user://metrics_runs.jsonl"

var _session_run_start_ms: int = 0


func start_run() -> void:
	_session_run_start_ms = Time.get_ticks_msec()


func finish_run(summary: Dictionary) -> void:
	var elapsed_ms: int = Time.get_ticks_msec() - _session_run_start_ms
	var payload: Dictionary = summary.duplicate(true)
	payload["run_duration_seconds"] = snapped(float(elapsed_ms) / 1000.0, 0.01)
	payload["timestamp_utc"] = Time.get_datetime_string_from_system(true, true)

	var file: FileAccess = FileAccess.open(METRICS_PATH, FileAccess.READ_WRITE)
	if file == null:
		file = FileAccess.open(METRICS_PATH, FileAccess.WRITE)
	if file == null:
		return

	file.seek_end()
	file.store_line(JSON.stringify(payload))
