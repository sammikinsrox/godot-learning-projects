extends Node2D


const TRIGGER_CONDITION: String = "parameters/conditions/on_trigger"
const HIT_ANIMATION_DURATION: float = 1.6


@export var lives: int = 5
@export var points: int = 5


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var visual: Node2D = $Visual
@onready var hitbox: Area2D = $Visual/Hitbox


var _invincible: bool = false
#var _tween: Tween


func _on_trigger_area_entered(_area: Area2D) -> void:
	animation_tree[TRIGGER_CONDITION] = true
	hitbox.monitoring = true


func _on_hitbox_area_entered(_area: Area2D) -> void:
	_take_damage()


func _set_invincible(invincible: bool) -> void:
	_invincible = invincible
	if invincible:
		state_machine.travel("hit")


func _take_damage() -> void:
	if _invincible == true:
		return
	
	_set_invincible(true)
	_tween_hit()
	_reduce_lives()


func _tween_hit() -> void:
	var tween = create_tween()
	tween.tween_property(visual, "position", Vector2.ZERO, HIT_ANIMATION_DURATION)


func _reduce_lives() -> void:
	lives -= 1
	if lives < 1:
		_die()


func _die() -> void:
	SignalManager.on_boss_killed.emit(points)
	queue_free()
