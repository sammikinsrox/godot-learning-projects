extends Node2D


const OBJECT_SCENES: Dictionary = {
	Constants.ObjectType.PICKUP: preload("res://scenes/fruit_pickup/fruit_pickup.tscn"),
	Constants.ObjectType.EXPLOSION: preload("res://scenes/explosion/explosion.tscn"),
	Constants.ObjectType.BULLET_PLAYER: preload("res://scenes/bullet_player/bullet_player.tscn"),
	Constants.ObjectType.BULLET_ENEMY: preload("res://scenes/bullet_enemy/bullet_enemy.tscn")
}


func _ready() -> void:
	SignalManager.on_create_bullet.connect(_on_create_bullet)
	SignalManager.on_create_object.connect(_on_create_object)


func _on_create_bullet(pos: Vector2, direction: Vector2, life_span: float, speed: float, object_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(object_type):
		return
		
	var new_bullet: Bullet = OBJECT_SCENES[object_type].instantiate()
	
	new_bullet.setup(pos, direction, speed, life_span)
	call_deferred("add_child", new_bullet)
	
	
func _on_create_object(pos: Vector2, object_type: Constants.ObjectType) -> void:
	if !OBJECT_SCENES.has(object_type):
		return
		
	var new_object = OBJECT_SCENES[object_type].instantiate()
	new_object.position = pos
	call_deferred("add_child", new_object)
