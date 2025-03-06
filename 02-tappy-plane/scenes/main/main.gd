extends Control


@onready var high_score: Label = $MarginContainer/HighScore


func _ready() -> void:
	high_score.text = str(ScoreManager.get_high_score())


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()
	
