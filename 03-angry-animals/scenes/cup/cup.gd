extends StaticBody2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func die() -> void:
	#print("Cup Died")
	animation_player.play("vanish")


func _on_animation_finished(_anim_name: StringName) -> void:
	Signals.on_cup_destroyed.emit()
	queue_free()
