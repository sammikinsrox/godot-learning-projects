extends Node2D

@export var gem_scene: PackedScene

var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	spawn_gem()
	

func spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	var xpos = randf_range(70, 1050)
	new_gem.position = Vector2(xpos, -50)
	new_gem.falling_speed = randi_range(50, 175)
	new_gem.on_gem_off_screen.connect(game_over)
	add_child(new_gem)


func game_over() -> void:
	print("game over dude")
	%GameOverLabel.visible = true
	%DeadSound.play()
	stop_all()
	
	
func stop_all() -> void:
	%Timer.stop()
	for child in get_children():
		child.set_process(false)

	
func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	%Label.text = "%05d" % _score
	%CollectSound.play()
	area.queue_free()
