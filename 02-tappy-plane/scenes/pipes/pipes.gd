class_name Pipes extends Node2D


@onready var score_sound: AudioStreamPlayer2D = $ScoreSound


func _ready() -> void:
	SignalManager.on_plane_died.connect(_on_plane_died)


func _process(delta: float) -> void:
	position.x += -GameManager.SCROLL_SPEED * delta


func _on_screen_exited() -> void:
	queue_free()
	
	
func _on_plane_died() -> void:
	set_process(false)
	
	
func _on_pipe_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_PLANE):
		body.die()
		

func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group(GameManager.GROUP_PLANE) and body.has_method("die"):
		#body.die()
	
	if body is Tappy:
		body.die()


func _on_laser_body_entered(body: Node2D) -> void:
	if body is Tappy:
		score_sound.play()
