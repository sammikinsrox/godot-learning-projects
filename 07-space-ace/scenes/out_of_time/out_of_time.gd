extends Node


@export var lifetime_in_seconds: float = 5.0


@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = lifetime_in_seconds
	timer.start()


func _on_timer_timeout() -> void:
	get_parent().queue_free()
