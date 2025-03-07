class_name Shield extends Area2D


@export var start_health: int = 5


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sound: AudioStreamPlayer2D = $Sound


var _health: int = start_health


func _ready() -> void:
	enable_shield()


func enable_shield() -> void:
	_health = start_health
	collision_shape_2d.call_deferred("set_disabled", false)
	timer.start()
	show()


func disable_shield() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)
	timer.stop()
	hide()


func _on_timer_timeout() -> void:
	disable_shield()


func _on_area_entered(area: Area2D) -> void:
	hit()


func hit() -> void:
	animation_player.play("hit")
	_health -= 1
	if _health <= 0:
		disable_shield()
