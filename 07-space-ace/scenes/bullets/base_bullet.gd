class_name BaseBullet extends Area2D

enum BulletType {
	PLAYER,
	ENEMY,
	ENEMYBOMB
}

var _direction: Vector2 = Vector2.UP
var _speed: float = 200.0


func _process(delta: float) -> void:
	position.y += _direction.y * _speed * delta


func setup(direction: Vector2, speed: float) -> void:
	_direction = direction.normalized()
	_speed = speed


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	blow_up()


func blow_up() -> void:
	SignalManager.on_create_explosion.emit(global_position, Explosion.ExplosionType.EXPLOSION)
	set_process(false)
	queue_free()
