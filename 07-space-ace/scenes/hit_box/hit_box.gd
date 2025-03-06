class_name HitBox extends Area2D

# The amount of damage this entity will be able to take. I think.
@export var damage: int = 5


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func deactivate_collision() -> void:
	collision_shape_2d.call_deferred("set_disabled", true)


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func get_damage() -> int:
	return damage
