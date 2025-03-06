extends Node2D


@export var camera_max: Vector2
@export var camera_min: Vector2

@onready var player: Player = $Player
@onready var sound: AudioStreamPlayer2D = $Sound


func _ready() -> void:
	SignalManager.on_game_over.connect(_on_game_over)
	SignalManager.on_level_complete.connect(_on_game_over)
	#player.set_camera_limits(camera_min, camera_max)
	_play_music()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("advance"):
		GameManager.load_next_level_scene()
	if Input.is_action_just_pressed("quit"):
		GameManager.load_main_scene()


func _on_game_over() -> void:
	var moveables = get_tree().get_nodes_in_group(Constants.MOVEABLES_GROUP)
	for moveable in moveables:
		moveable.set_process(false)
		moveable.set_physics_process(false)

func _play_music():
	SoundManager.play_clip(sound, SoundManager.SOUND_MUSIC2)
