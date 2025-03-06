extends EnemyBase


const JUMP_VELOCITY_X: float = 100.0
const JUMP_VELOCITY_Y: float = 150.0
const JUMP_VELOCITY_R: Vector2 = Vector2(JUMP_VELOCITY_X, -JUMP_VELOCITY_Y)
const JUMP_VELOCITY_L: Vector2 = Vector2(-JUMP_VELOCITY_X, -JUMP_VELOCITY_Y)


@export_category("Jump Delay")
@export var jump_delay_min: float = 2.0
@export var jump_delay_max: float = 4.0


var _can_jump: bool = false
var _seen_player: bool = false


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_timer: Timer = $JumpTimer


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if not is_on_floor():
		velocity.y += _gravity * delta
	elif is_on_floor():
		velocity.x = 0
		animated_sprite_2d.play("idle")
	_apply_jump()
	move_and_slide()
	
	if is_on_floor():
		_flip_me()


func _on_jump_timer_timeout() -> void:
	_can_jump = true
	_start_timer()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	_seen_player = true
	_start_timer()


func _flip_me() -> void:
	if player_ref.global_position.x > self.global_position.x and not animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = true
	elif player_ref.global_position.x < self.global_position.x and animated_sprite_2d.flip_h:
		animated_sprite_2d.flip_h = false


func _apply_jump() -> void:
	# If frog is not on the floor, can't see the player, or can't jump, then return, else proceed.
	if not is_on_floor() or not  _seen_player or not _can_jump:
		return
		
	if not animated_sprite_2d.flip_h:
		velocity = JUMP_VELOCITY_L
	elif animated_sprite_2d.flip_h:
		velocity = JUMP_VELOCITY_R
	
	_can_jump = false
	
	animated_sprite_2d.play("jump")


func _start_timer() -> void:
	jump_timer.wait_time = randf_range(jump_delay_min, jump_delay_max)
	jump_timer.start()
