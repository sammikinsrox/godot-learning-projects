extends Node2D

const ENEMY_BOMB: PackedScene = preload("res://scenes/bullets/enemy_bomb.tscn")
const ENEMY_BULLET: PackedScene = preload("res://scenes/bullets/enemy_bullet.tscn")
const PLAYER_BULLET: PackedScene = preload("res://scenes/bullets/player_bullet.tscn")
const BASE_BULLET: PackedScene = preload("res://scenes/bullets/base_bullet.tscn")
const ADD_OBJECT: String = "add_object"


func _ready() -> void:
	SignalManager.on_create_bullet.connect(_on_create_bullet)


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
		
