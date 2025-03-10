class_name Gem extends Area2D

@export var falling_speed: float

signal on_gem_off_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_gem(delta)
	
func move_gem(delta: float) -> void:
	position.y += falling_speed * delta
	if position.y > get_viewport_rect().size.y:
		on_gem_off_screen.emit()
		set_process(false)
		queue_free()
