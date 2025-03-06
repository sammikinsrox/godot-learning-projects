class_name Shield extends Area2D


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound


func _ready() -> void:
	enable_shield()


func enable_shield() -> void:
	collision_shape_2d.call_deferred("set_disabled", false)
	timer.start()
	show()


func disable_shield() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)
	timer.stop()
	hide()


func _on_timer_timeout() -> void:
	disable_shield()
