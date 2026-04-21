extends Control

# Dramatic full-screen overlay shown at the moment a run ends.
# Reuses the advisor portraits as the "face" of each outcome so the cast feels
# persistent: the Chancellor crowns a victory, the Plaguewright heralds a
# defeat, and a neutral timeout falls to the Arcanist (the study continues).
#
# The overlay fades in, holds, and then emits `finished` so run_scene can
# transition to MetaHub while keeping the visual beat.

signal finished

const ADVISOR_BY_OUTCOME: Dictionary = {
	"victory": "res://assets/art/advisors/advisor_chancellor.png",
	"chapter_cleared": "res://assets/art/advisors/advisor_chancellor.png",
	"defeat": "res://assets/art/advisors/advisor_plaguewright.png",
	"loss": "res://assets/art/advisors/advisor_plaguewright.png",
	"timeout": "res://assets/art/advisors/advisor_arcanist.png",
	"ongoing": "res://assets/art/advisors/advisor_arcanist.png",
}

const TITLE_BY_OUTCOME: Dictionary = {
	"victory": "VICTORY",
	"chapter_cleared": "VICTORY",
	"defeat": "DEFEAT",
	"loss": "DEFEAT",
	"timeout": "TIME OUT",
	"ongoing": "SUSPENDED",
}

const SUBTITLE_BY_OUTCOME: Dictionary = {
	"victory": "The coalition holds. The Ash remembers you.",
	"chapter_cleared": "The coalition holds. The Ash remembers you.",
	"defeat": "Your coalition crumbles under the plague.",
	"loss": "Your coalition crumbles under the plague.",
	"timeout": "Time drains. The council adjourns.",
	"ongoing": "The run is suspended mid-council.",
}

# Palette (Ashen Fresco)
const D0: Color = Color(0.059, 0.039, 0.055, 1.0)
const D1: Color = Color(0.122, 0.082, 0.125, 1.0)
const D2: Color = Color(0.180, 0.133, 0.157, 1.0)
const C3: Color = Color(0.772, 0.671, 0.557, 1.0)
const C4: Color = Color(0.910, 0.831, 0.706, 1.0)
const O3: Color = Color(0.780, 0.604, 0.235, 1.0)
const O4: Color = Color(0.910, 0.753, 0.408, 1.0)
const O5: Color = Color(0.969, 0.902, 0.659, 1.0)
const R3: Color = Color(0.698, 0.165, 0.204, 1.0)
const R4: Color = Color(0.851, 0.329, 0.306, 1.0)
const G3: Color = Color(0.659, 0.737, 0.349, 1.0)

const HOLD_SECONDS: float = 2.8
const FADE_IN: float = 0.45
const FADE_OUT: float = 0.35

var _outcome: String = "ongoing"
var _time: float = 0.0
var _active: bool = false
var _dismiss_allowed_at: float = 0.0

@onready var _dim: ColorRect = $Dim
@onready var _card: PanelContainer = $Card
@onready var _portrait: TextureRect = $Card/Margin/VBox/PortraitCenter/Portrait
@onready var _title_label: Label = $Card/Margin/VBox/Title
@onready var _subtitle_label: Label = $Card/Margin/VBox/Subtitle
@onready var _hint_label: Label = $Card/Margin/VBox/Hint


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = false
	set_process(false)
	# Clear any placeholder text that might ship inside RunEndOverlay.tscn so a
	# late layout hiccup / tool inspection never surfaces a misleading "VICTORY".
	if _title_label:
		_title_label.text = ""
	if _subtitle_label:
		_subtitle_label.text = ""
	if _hint_label:
		_hint_label.text = ""
	if _portrait:
		_portrait.texture = null
		_portrait.visible = false


func show_outcome(outcome: String) -> void:
	_outcome = String(outcome).to_lower()
	visible = true
	_active = true
	_time = 0.0
	_dismiss_allowed_at = 0.6

	# Warn (don't crash) when a caller passes an outcome the overlay can't mood-map.
	# This catches BUG-003-class regressions where WorldSimulation emits a string
	# (e.g. "win") that none of our dictionaries recognize.
	if not TITLE_BY_OUTCOME.has(_outcome):
		push_warning("RunEndOverlay.show_outcome: unknown outcome '%s'. Falling back to 'RUN OVER'. Callers should translate sim outcomes (win/loss) into overlay moods (victory/defeat)." % _outcome)

	var portrait_path: String = String(ADVISOR_BY_OUTCOME.get(_outcome, ADVISOR_BY_OUTCOME["ongoing"]))
	var tex: Texture2D = load(portrait_path) if ResourceLoader.exists(portrait_path) else null
	_portrait.texture = tex
	_portrait.visible = tex != null

	_title_label.text = String(TITLE_BY_OUTCOME.get(_outcome, "RUN OVER"))
	_subtitle_label.text = String(SUBTITLE_BY_OUTCOME.get(_outcome, ""))
	_hint_label.text = "Continue →"

	# Title colour matches outcome mood.
	var title_color: Color = O4
	if _outcome in ["defeat", "loss"]:
		title_color = R4
	elif _outcome in ["timeout", "ongoing"]:
		title_color = C4
	_title_label.add_theme_color_override("font_color", title_color)
	_title_label.add_theme_color_override("font_outline_color", D0)
	_title_label.add_theme_constant_override("outline_size", 6)

	# Portrait gets a slight punch-in on show.
	_portrait.pivot_offset = _portrait.size * 0.5
	_portrait.scale = Vector2(0.82, 0.82)
	_card.modulate.a = 0.0
	_dim.modulate.a = 0.0

	var tw := create_tween()
	tw.set_parallel(true)
	tw.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_property(_dim, "modulate:a", 0.82, FADE_IN)
	tw.tween_property(_card, "modulate:a", 1.0, FADE_IN)
	var pt := create_tween()
	pt.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	pt.tween_property(_portrait, "scale", Vector2.ONE, 0.55)

	set_process(true)
	set_process_input(true)
	queue_redraw()


func _process(delta: float) -> void:
	_time += delta
	# Pulse the hint after 1.2s to telegraph "click to advance".
	if _time > 1.0:
		var pulse: float = 0.55 + 0.45 * sin(_time * 4.0)
		_hint_label.modulate.a = pulse
	if _time >= HOLD_SECONDS and _active:
		_dismiss()
	queue_redraw()


func _input(event: InputEvent) -> void:
	if not _active:
		return
	if _time < _dismiss_allowed_at:
		return
	if event is InputEventMouseButton and event.pressed:
		_dismiss()
		accept_event()
	elif event is InputEventKey and event.pressed:
		_dismiss()
		accept_event()


func _dismiss() -> void:
	if not _active:
		return
	_active = false
	set_process(false)
	set_process_input(false)
	var tw := create_tween()
	tw.set_parallel(true)
	tw.tween_property(_dim, "modulate:a", 0.0, FADE_OUT)
	tw.tween_property(_card, "modulate:a", 0.0, FADE_OUT)
	tw.chain().tween_callback(_emit_finished)


func _emit_finished() -> void:
	visible = false
	finished.emit()


# Additional decorative rays behind the card (painted via custom draw on the
# backdrop). Creates a soft "dawn" or "eclipse" radial pattern based on outcome.
func _draw() -> void:
	if not visible or not _active:
		return
	var sz: Vector2 = size
	var center: Vector2 = Vector2(sz.x * 0.5, sz.y * 0.42)
	var is_defeat: bool = _outcome in ["defeat", "loss"]
	var ray_color: Color = O3 if not is_defeat else R3
	ray_color.a = 0.18
	var n_rays: int = 16
	var length: float = sz.length() * 0.6
	for i in range(n_rays):
		var t: float = float(i) / float(n_rays)
		var ang: float = TAU * t + _time * (0.15 if not is_defeat else -0.10)
		var dir: Vector2 = Vector2(cos(ang), sin(ang))
		var tip: Vector2 = center + dir * length
		var width: float = 3.0
		var fade: Color = ray_color
		fade.a = ray_color.a * (0.5 + 0.5 * sin(_time * 1.3 + i))
		draw_line(center, tip, fade, width, true)
	# Subtle central vignette.
	for i in range(6):
		var r: float = 80.0 + i * 36.0
		var ring_color: Color = O4 if not is_defeat else R4
		ring_color.a = 0.06 - i * 0.009
		if ring_color.a > 0.0:
			draw_circle(center, r, ring_color)
