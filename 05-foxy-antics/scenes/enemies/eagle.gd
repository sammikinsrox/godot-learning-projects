extends EnemyBase


const FLY_SPEED: Vector2 = Vector2(35, 15)


var _fly_direction: Vector2 = Vector2.ZERO


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shooter: Shooter = $Shooter
@onready var player_detector: RayCast2D = $PlayerDetector
@onready var direction_timer: Timer = $DirectionTimer


func _ready() -> void:
	super._ready()


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = _fly_direction
	move_and_slide()
	_shoot()


func _shoot() -> void:
	if player_detector.is_colliding():
		shooter.shoot(global_position.direction_to(player_ref.global_position))


func _fly_to_player() -> void:
	var x_direction: float = sign(player_ref.global_position.x - global_position.x)
	if x_direction > 0:
		animated_sprite_2d.flip_h = true
	elif x_direction < 1:
		animated_sprite_2d.flip_h = false
		
	_fly_direction = Vector2(x_direction, 1) * FLY_SPEED


func _on_direction_timer_timeout() -> void:
	_fly_to_player()
	
	
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	animated_sprite_2d.play("fly")
	direction_timer.start()
	_fly_to_player()
