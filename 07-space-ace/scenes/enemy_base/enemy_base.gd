class_name EnemyBase extends PathFollow2D


@export var _speed: float = 50.0





func _process(delta: float) -> void:
	progress += _speed * delta
	
	if progress_ratio > 0.99:
		queue_free()


func setup(speed: float) -> void:
	_speed = speed
