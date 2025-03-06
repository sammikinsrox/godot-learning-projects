class_name Tappy extends CharacterBody2D


const GRAVITY: float  = 1500.0
const POWER: float = 350.0

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var engine_sound: AudioStreamPlayer2D = $EngineSound


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:	
	fly()
	fall(delta)
	move_and_slide()
	
	if is_on_floor():
		die()


func fly() -> void:
	$EngineSound.play()
	if Input.is_action_just_pressed("fly"):
		velocity.y = -POWER
		animation_player.play("power")
		

func fall(delta: float) -> void:
	velocity.y += GRAVITY * delta
	

func die() -> void:
	engine_sound.stop()
	set_physics_process(false)
	%AnimatedSprite2D.stop()
	SignalManager.on_plane_died.emit()
