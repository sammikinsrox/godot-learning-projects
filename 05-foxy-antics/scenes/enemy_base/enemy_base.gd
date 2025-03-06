class_name EnemyBase extends CharacterBody2D


const OFF_SCREEN_KILL_ME: float = 200.0


@export var points: int = 1


var player_ref: Player


var _gravity: float = 800
var _dying: bool = false


func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)


func _physics_process(_delta: float) -> void:
	_fallen_off()


func _fallen_off() -> void:
	if global_position.y > OFF_SCREEN_KILL_ME:
		queue_free()


func die() -> void:
	if _dying:
		return
		
	_dying = true
	
	set_physics_process(false)
	hide()
	
	SignalManager.on_enemy_hit.emit(points)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.EXPLOSION)
	SignalManager.on_create_object.emit(global_position, Constants.ObjectType.PICKUP)
	
	# TODO: Add Sound: Sound
	
	queue_free()


func _on_hit_box_area_entered(_area: Area2D) -> void:
	die()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass
