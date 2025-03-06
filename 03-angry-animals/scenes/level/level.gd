extends Node2D


const ANIMAL: PackedScene = preload("res://scenes/animal/animal.tscn")


@onready var animal_start: Marker2D = $AnimalStart


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.animal_died.connect(_on_animal_died)
	spawn_animal()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		#Signals.load_level.emit(GameManager.levels[0])
		get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
	
func _on_animal_died() -> void:
	spawn_animal()
	
	
func spawn_animal() -> void:
	var animal = ANIMAL.instantiate()
	animal.position = $AnimalStart.position
	add_child(animal)
