class_name Bullet extends Area2D


var _direction: Vector2 = Vector2(100, -50)
var _life_span: float = 20
var _life_time: float = 0.0


func _process(delta: float) -> void:
	position += _direction * delta
	check_expired(delta)


func setup(pos: Vector2, direction: Vector2, speed: float, life_span: float):
	_direction = direction.normalized() * speed
	_life_span = life_span
	global_position = pos



func check_expired(delta: float) -> void:
	_life_time += delta
	if _life_time > _life_span:
		queue_free()


func _on_area_entered(_area: Area2D) -> void:
	queue_free()
