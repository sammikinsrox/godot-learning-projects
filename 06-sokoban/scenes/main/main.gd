extends Control


const LEVEL_BUTTON = preload("res://scenes/level_button/level_button.tscn")
const LEVEL_COLS: int = 6
const LEVEL_ROWS: int = 5


@onready var level_buttons_container: GridContainer = $MarginContainer/VBoxContainer/LevelButtonsContainer


func _ready() -> void:
	setup_grid()


func setup_grid() -> void:
	for level in range(LEVEL_COLS * LEVEL_ROWS):
		var lb: LevelButton = LEVEL_BUTTON.instantiate()
		lb.set_level_number(str(level+1))
		level_buttons_container.add_child(lb)
