class_name Hud extends Control


@onready var level_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/LevelLabel
@onready var moves_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/MovesLabel
@onready var best_label: Label = $MarginContainer/VBoxContainer/HBoxContainer3/BestLabel


func new_game(level: String) -> void:
	var best: int = ScoreSync.get_level_best_score(level)
	best_label.text = "-" if best == ScoreSync.DEFAULT_SCORE else str(best)
	
	level_label.text = level
	set_move_label(0)
	

func set_move_label(moves: int) -> void:
	moves_label.text = str(moves)
