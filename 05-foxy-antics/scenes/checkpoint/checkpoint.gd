extends Area2D

const TRIGGER_CONDITION: String = "parameters/conditions/on_triggered"


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	SignalManager.on_boss_killed.connect(_on_boss_killed)
	sprite_2d.hide()


func _on_boss_killed(_points) -> void:
	monitoring = true
	sprite_2d.show()
	SoundManager.play_clip(sound, SoundManager.SOUND_CHECKPOINT)


func _on_area_entered(_area: Area2D) -> void:
	animation_tree[TRIGGER_CONDITION] = true
	SoundManager.play_clip(sound, SoundManager.SOUND_WIN)
	SignalManager.on_level_complete.emit()
