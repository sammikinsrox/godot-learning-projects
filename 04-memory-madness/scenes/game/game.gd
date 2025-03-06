extends Control


const MEMORY_TILE = preload("res://scenes/memory_tile/memory_tile.tscn")


var _moves_made: int = 0
var _pairs_made: int = 0


@onready var tiles_container: GridContainer = $HBoxContainer/MarginContainer/TilesContainer
@onready var moves_value: Label = $HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer/MovesValue
@onready var pairs_value: Label = $HBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer2/PairsValue
@onready var scorer: Scorer = $Scorer
@onready var game_over_ui: Control = $GameOverUI
@onready var sound: AudioStreamPlayer = $Sound


func _ready() -> void:
	SignalManager.on_level_selected.connect(_on_level_selected)
	SignalManager.on_move_made.connect(_on_move_made)
	SignalManager.on_pair_made.connect(_on_pair_made)


func _on_level_selected(level_number: int) -> void:
	var level_data: SelectedLevelData = GameManager.get_level_selection(level_number)
	var frame: Texture2D = ImageManager.get_random_frame_image()
	
	tiles_container.columns = level_data.get_num_columns()
	
	for image in level_data.get_selected_level_images():
		add_memory_tile(image, frame)
		
	scorer.clear_new_game(level_data.get_target_pairs())

func _on_move_made() -> void:
	_moves_made += 1
	moves_value.text = str(_moves_made)


func _on_pair_made() -> void:
	_pairs_made += 1
	pairs_value.text = str(_pairs_made)


func _on_exit_button_pressed() -> void:
	for tile in tiles_container.get_children():
		tile.queue_free()
		
	SignalManager.on_game_exit_pressed.emit()
	SoundManager.play_button_click(sound)
	game_over_ui.hide()
	


func add_memory_tile(image: ItemImage, frame:Texture2D) -> void:
	var new_tile: MemoryTile = MEMORY_TILE.instantiate()
	tiles_container.add_child(new_tile)
	new_tile.setup(image, frame)
	
