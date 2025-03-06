class_name Player extends Area2D

const PLAYER_MOVE_MARGIN: float = 16.0


@export var speed: float = 250.0


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var _player_move_min: Vector2
var _player_move_max: Vector2


func _ready() -> void:
	_get_position_clamp()


func _process(delta: float) -> void:
	var input = _get_input()
	global_position += input * delta * speed
	global_position = global_position.clamp(_player_move_min, _player_move_max)


func _get_position_clamp() -> void:
	_player_move_max = Vector2(get_viewport_rect().size.x - PLAYER_MOVE_MARGIN, get_viewport_rect().size.y - PLAYER_MOVE_MARGIN)
	_player_move_min = Vector2(PLAYER_MOVE_MARGIN, PLAYER_MOVE_MARGIN)


func _get_input() -> Vector2:
	var vector = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)
	
	_check_sprite_animation(vector)
	return vector.normalized()

func _check_sprite_animation(vector: Vector2) -> void:
	if vector.x != 0:
		animation_player.play("turn")
		sprite_2d.flip_h = true if vector.x > 0 else false
	else:
		animation_player.play("fly")
