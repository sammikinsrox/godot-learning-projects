extends Node

# Animal Signals
signal animal_died

# Cup Signals
signal on_cup_destroyed
signal on_attempt_made
signal on_score_updated(attempts: int)
signal on_level_completed

# GameManager Signals
signal load_level(level)

func _ready() -> void:
	#animal_died.connect(test_print)
	#on_cup_destroyed.connect(test_print)
	pass
	

func test_print() -> void:
	print("Signal Emitted Successfully.")
