extends TextureButton

const HOVER_SCALE: Vector2 = Vector2(1.1, 1.1)
const DEFAULT_SCALE: Vector2 = Vector2(1.0, 1.0)


@export var level_number: int


@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel


func _ready() -> void:
	var level_number_str = str(level_number)
	var best_score = ScoreManager.get_best_score_for_level(level_number_str)
	level_label.text = level_number_str
	score_label.text = str(best_score)


func _on_pressed() -> void:
	Signals.load_level.emit(str(level_number))


func _on_mouse_entered() -> void:
	scale = HOVER_SCALE


func _on_mouse_exited() -> void:
	scale = DEFAULT_SCALE
