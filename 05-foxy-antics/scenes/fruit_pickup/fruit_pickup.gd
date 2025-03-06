extends Area2D


const GRAVITY: float = 160.0
const JUMP_AMOUNT: float = -120.0
const POINTS: int = 2


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


var _start_y: float
var _speed_y: float = JUMP_AMOUNT


func _ready() -> void:
	
	_start_y = position.y
	_select_fruit()


func _process(delta: float) -> void:
	position.y += _speed_y * delta
	_speed_y += GRAVITY * delta
	
	if position.y > _start_y:
		set_process(false)


func _select_fruit() -> void:
	var ln: Array[String]
	for animation_name in animated_sprite_2d.sprite_frames.get_animation_names():
		ln.push_back(animation_name)
	animated_sprite_2d.animation = ln.pick_random()


func _die() -> void:
	hide()
	queue_free()


func _on_life_timer_timeout() -> void:
	_die()


func _on_area_entered(_area: Area2D) -> void:
	SignalManager.on_pickup_hit.emit(POINTS)
	_die()
