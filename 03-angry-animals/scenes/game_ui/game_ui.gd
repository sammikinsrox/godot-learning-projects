extends Control


@onready var level_value: Label = $ScoreContainer/Level/LevelValue
@onready var attempts_value: Label = $ScoreContainer/Shots/AttemptsValue
@onready var level_complete_label: Label = $LevelCompleteContainer/LevelCompleteLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _attempts_made: int = 0
var _cups_destroyed: int = 0
var _current_score: int = 0
var _total_cups: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_value.text = GameManager.get_selected_level()
	attempts_value.text = str(0)
	_total_cups = get_tree().get_nodes_in_group("cup").size()
	
	Signals.on_attempt_made.connect(_on_attempt_made)
	Signals.on_cup_destroyed.connect(_on_cup_destroyed)
	Signals.on_level_completed.connect(_on_level_complete)
	
	level_complete_label.hide()


func _on_attempt_made() -> void:
	_attempts_made += 1
	attempts_value.text = str(_attempts_made)
	

func _on_cup_destroyed() -> void:
	_cups_destroyed += 1


func _on_level_complete() -> void:
	level_complete_label.show()
	animation_player.play("flash_level_complete")
