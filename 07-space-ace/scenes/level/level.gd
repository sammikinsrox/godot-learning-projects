extends Node2D

const TEST_BULLET_SPAWN_LOCATION: Vector2 = Vector2(100, 100)
const TEST_BULLET_TRAVEL_DIRECTION: Vector2 = Vector2.DOWN
const TEST_BULLET_SPEED: float = 50.0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		GameManager.load_main_scene()
	if Input.is_action_just_pressed("maker"):
		SignalManager.on_create_bullet.emit(Vector2(TEST_BULLET_SPAWN_LOCATION), TEST_BULLET_TRAVEL_DIRECTION, TEST_BULLET_SPEED, BaseBullet.BulletType.ENEMY)
