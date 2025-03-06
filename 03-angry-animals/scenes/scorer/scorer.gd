extends Node


var _attempts: float = 0
var _cups_destroyed: float = 0
var _total_cups: int
var _level_number: String


func _ready() -> void:
	# Connect Signals
	Signals.on_attempt_made.connect(_on_attempt_made)
	Signals.on_cup_destroyed.connect(_on_cup_destroyed)
	
	# Initial values
	_total_cups = get_tree().get_nodes_in_group("cup").size()
	_level_number = GameManager.get_selected_level()


func _on_attempt_made() -> void:
	_attempts += 1
	Signals.on_score_updated.emit(_attempts)


func _on_cup_destroyed() -> void:
	print("Level number ", _level_number)
	_cups_destroyed += 1
	print("score ", _get_score())
	if _cups_destroyed == _total_cups:
		Signals.on_level_completed.emit()
		ScoreManager.set_score_for_level(_get_score(), _level_number)


func _get_score() -> float:
	return int((_total_cups / _attempts) * 1000)
