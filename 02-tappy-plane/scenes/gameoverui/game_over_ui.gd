extends Control


@onready var space_label: Label = $VBoxContainer/SpaceLabel
@onready var timer: Timer = $Timer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	SignalManager.on_plane_died.connect(_on_plane_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("fly") and space_label.visible:
		GameManager.load_main_scene()


func _on_plane_died() -> void:
	show()
	timer.start()
	audio_stream_player.play()
	
	ScoreManager.save_high_score_to_file()


func _on_timer_timeout() -> void:
	animation_player.play("fade_in")
	space_label.show()
