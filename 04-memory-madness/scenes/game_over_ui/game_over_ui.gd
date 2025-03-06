extends Control


@onready var moves_label: Label = $NinePatchRect/MarginContainer/VBoxContainer/MovesLabel


func _ready() -> void:
	SignalManager.on_game_over.connect(_on_game_over)
	

func _on_game_over(moves: int):
	moves_label.text = "You took %d moves" % moves
	show()
