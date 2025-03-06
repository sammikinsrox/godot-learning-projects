extends Area2D


func _on_body_entered(_body: Node2D) -> void:
	SignalManager.on_plane_pass.emit()
