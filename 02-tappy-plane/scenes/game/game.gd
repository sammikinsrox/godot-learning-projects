extends Node2D

const PIPES: PackedScene = preload("res://scenes/pipes/pipes.tscn")

@onready var spawn_u: Marker2D = $SpawnU
@onready var spawn_l: Marker2D = $SpawnL
@onready var pipe_timer: Timer = $PipeTimer
@onready var pipes_holder: Node = $PipesHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.set_score(0)
	SignalManager.on_plane_died.connect(_on_plane_died)
	spawn_pipes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
	
func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var ypos: float = randf_range(spawn_l.position.y, spawn_u.position.y)
	new_pipes.position = Vector2(spawn_l.position.x, ypos)
	pipes_holder.add_child(new_pipes)


func _on_pipe_timer_timeout() -> void:
	spawn_pipes()


func _on_plane_died() -> void:
	%GameOverUI.show()
	$PipeTimer.stop()
	
	for child: Parallax2D in %ParallaxBG.get_children():
		child.autoscroll.x = 0 
