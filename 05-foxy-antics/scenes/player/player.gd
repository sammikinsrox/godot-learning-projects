class_name Player extends CharacterBody2D


enum PlayerState { IDLE, RUN, JUMP, FALL, HURT}


const GRAVITY: float = 690.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const JUMP_VELOCITY: float = -260.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130.0)
const FALLEN_OFF: float = 200


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shooter: Shooter = $Shooter
@onready var invincible_timer: Timer = $InvincibleTimer
@onready var invincible_player: AnimationPlayer = $InvinciblePlayer
@onready var hurt_timer: Timer = $HurtTimer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var player_cam: Camera2D = $PlayerCam


var _state: PlayerState = PlayerState.IDLE
var _invincible: bool = false
var _lives: int = 5


func _ready() -> void:
	call_deferred("_deferred_setup")


func _physics_process(delta: float) -> void:
	
	fallen_off()
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	get_input()
	move_and_slide()
	calculate_states()
	update_debug_label()


func _deferred_setup() -> void:
	SignalManager.on_level_started.emit(_lives)

func update_debug_label() -> void:
	debug_label.text = "floor: %s\n%.0f,%.0f\n%s\n invinc:%s lives:%d" % [is_on_floor(), velocity.x, velocity.y, PlayerState.keys()[_state], _invincible, _lives]

func get_input() -> void:
	if _state == PlayerState.HURT:
		return
	
	# Set the initial velocity.
	velocity.x = 0
	
	# Get which actions are being pressed.
	if Input.is_action_pressed("walk_left"):
		velocity.x -= RUN_SPEED
		sprite_2d.flip_h = true
	elif Input.is_action_pressed("walk_right"):
		velocity.x += RUN_SPEED
		sprite_2d.flip_h = false
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SoundManager.play_clip(sound, SoundManager.SOUND_JUMP)
		
	if Input.is_action_just_pressed("shoot"):
		shoot()

	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func calculate_states() -> void:
	if _state == PlayerState.HURT:
		return
		
	if is_on_floor():
		if velocity.x == 0:
			set_states(PlayerState.IDLE)
		else:
			set_states(PlayerState.RUN)
	else:
		if velocity.y > 0:
			set_states(PlayerState.FALL)
		else:
			set_states(PlayerState.JUMP)


func set_states(new_state: PlayerState) -> void:
	if new_state == _state:
		return

	
	if _state == PlayerState.FALL:
		if new_state == PlayerState.IDLE or new_state == PlayerState.RUN:
			SoundManager.play_clip(sound, SoundManager.SOUND_LAND)
	
	_state = new_state
	
	match _state:
		PlayerState.IDLE:
			animation_player.play("idle")
		PlayerState.RUN:
			animation_player.play("run")
		PlayerState.JUMP:
			animation_player.play("jump")
		PlayerState.FALL:
			animation_player.play("fall")
		PlayerState.HURT:
			_apply_hurt_jump()


func fallen_off() -> void:
	if global_position.y < FALLEN_OFF:
		return
	_reduce_lives(_lives)


func _apply_hit() -> void:
	if _invincible:
		return
	
	_reduce_lives(1)
	
	if not _is_alive():
		return
	
	SoundManager.play_clip(sound, SoundManager.SOUND_DAMAGE)
	_go_invincible()
	set_states(PlayerState.HURT)


func _apply_hurt_jump() -> void:
	animation_player.play("hurt")
	velocity = HURT_JUMP_VELOCITY
	hurt_timer.start()


func _go_invincible() -> void:
	_invincible = true
	invincible_player.play("invincible")
	invincible_timer.start()
	

func _reduce_lives(reduction: int) -> void:
	_lives -= reduction
	SignalManager.on_player_hit.emit(_lives)
	if _lives < 1:
		SignalManager.on_game_over.emit()
		set_physics_process(false)


func _is_alive() -> bool:
	return _lives > 1


func shoot() -> void:
	if sprite_2d.flip_h:
		shooter.shoot(Vector2.LEFT)
	elif not sprite_2d.flip_h:
		shooter.shoot(Vector2.RIGHT)


func _on_invincible_timer_timeout() -> void:
	_invincible = false
	invincible_player.stop()


func _on_hitbox_area_entered(_area: Area2D) -> void:
	_apply_hit()


func _on_hurt_timer_timeout() -> void:
	set_states(PlayerState.IDLE)
	
func set_camera_limits(limit_min: Vector2, limit_max: Vector2) -> void:
	player_cam.limit_bottom = limit_min.y
	player_cam.limit_left = limit_min.x
	player_cam.limit_top = limit_max.y
	player_cam.limit_right = limit_max.x
