extends Area2D

@export var paddle_speed: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("paddle_move_left") and position.x > 55:
		position.x += -paddle_speed * delta
	elif Input.is_action_pressed("paddle_move_right") and position.x < get_viewport_rect().size.x - 55:
		position.x += paddle_speed * delta
