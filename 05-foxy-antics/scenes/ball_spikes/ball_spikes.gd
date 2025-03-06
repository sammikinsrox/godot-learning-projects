extends PathFollow2D


@export var speed: float = 0.05
@export var spin_speed: float = 400.0



func _process(delta: float) -> void:
	progress_ratio += delta * speed
	rotation_degrees += spin_speed * delta
	
