extends Control

@onready var score: Label = $MarginContainer/Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_plane_pass.connect(_on_plane_pass)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_plane_pass() -> void:
	ScoreManager.increment_score()
	score.text = str(ScoreManager.get_score())
