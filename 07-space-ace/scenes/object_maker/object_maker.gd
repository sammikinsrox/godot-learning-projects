extends Node2D

const ENEMY_BOMB: PackedScene = preload("res://scenes/bullets/enemy_bomb.tscn")
const ENEMY_BULLET: PackedScene = preload("res://scenes/bullets/enemy_bullet.tscn")
const PLAYER_BULLET: PackedScene = preload("res://scenes/bullets/player_bullet.tscn")
const BASE_BULLET: PackedScene = preload("res://scenes/bullets/base_bullet.tscn")
const POWER_UP: PackedScene = preload("res://scenes/power_up/power_up.tscn")
const EXPLOSION = preload("res://scenes/explosion/explosion.tscn")

const ADD_OBJECT: String = "add_object"


func _ready() -> void:
	SignalManager.on_create_bullet.connect(_on_create_bullet)
	SignalManager.on_create_powerup.connect(_on_create_powerup)
	SignalManager.on_create_explosion.connect(_on_create_explosion)


func add_object(object: Node, global_pos: Vector2) -> void:
	add_child(object)
	object.global_position = global_pos
	

func _on_create_bullet(start_pos: Vector2, direction: Vector2, speed: float, bullet_type: BaseBullet.BulletType) -> void:
	var scene: BaseBullet
	match bullet_type:
		BaseBullet.BulletType.PLAYER:
			scene = PLAYER_BULLET.instantiate()
		BaseBullet.BulletType.ENEMY:
			scene = ENEMY_BULLET.instantiate()
		BaseBullet.BulletType.ENEMYBOMB:
			scene = ENEMY_BOMB.instantiate()
	if scene:
		scene.setup(direction, speed)
		call_deferred(ADD_OBJECT, scene, start_pos)
		
func _on_create_powerup(start_position: Vector2, powerup_type: PowerUp.PowerUpType):
	var pu: PowerUp = POWER_UP.instantiate()
	pu.set_power_up_type(powerup_type)
	call_deferred(ADD_OBJECT, pu, start_position)

func _on_create_explosion(start_pos: Vector2, et: Explosion.ExplosionType ) -> void:
	var scene: Explosion = EXPLOSION.instantiate()
	scene.setup(et)
	call_deferred(ADD_OBJECT, scene, start_pos)
