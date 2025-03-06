extends Control


const HIGHSCORE_LABEL = preload("res://scenes/highscore_label/highscore_label.tscn")


@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer


func _ready() -> void:
	_set_scores()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump") or Input.is_action_just_released("advance"):
		GameManager.load_next_level_scene()


func _set_scores() -> void:
	for child in grid_container.get_children():
		grid_container.remove_child(child)
		
	for score in ScoreManager.get_score_history():
		var lb: Label = HIGHSCORE_LABEL.instantiate()
		lb.text = "%0000d" % [score]
		grid_container.add_child(lb)
