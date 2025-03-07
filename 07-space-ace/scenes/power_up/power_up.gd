class_name PowerUp extends HitBox


enum PowerUpType {
	SHIELD,
	HEALTH,
}


const POWERUP_GREEN_BOLT: CompressedTexture2D = preload("res://assets/misc/powerupGreen_bolt.png")
const SHIELD_GOLD: CompressedTexture2D = preload("res://assets/misc/shield_gold.png")

const SPRITE_SCALE: Vector2 = Vector2(0.5, 0.5)

const TEXTURES: Dictionary = {
	PowerUpType.SHIELD: SHIELD_GOLD,
	PowerUpType.HEALTH: POWERUP_GREEN_BOLT,
}


@export var _speed: float = 50.0
@export var _power_up_type: PowerUpType = PowerUpType.HEALTH


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var out_of_time: Node = $OutOfTime
@onready var sound: AudioStreamPlayer2D = $Sound


var _selected_texture: CompressedTexture2D


func _ready() -> void:
	_set_selected_texture()
	_set_sprite_scale()


func _physics_process(delta: float) -> void:
	global_position.y += _speed * delta


func set_power_up_type(power_up_type: PowerUpType) -> void:
	_power_up_type = power_up_type


func get_power_up_type() -> PowerUpType:
	return _power_up_type
	
	
func _set_selected_texture() -> void:
	_selected_texture = TEXTURES[_power_up_type]
	sprite_2d.texture = _selected_texture

func _set_sprite_scale() -> void:
	sprite_2d.scale = SPRITE_SCALE


func _on_area_entered(area: Area2D) -> void:
	queue_free()
