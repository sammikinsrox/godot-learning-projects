extends Node

# Navigation Signals
signal on_game_exit_pressed
signal on_level_selected(level: int)

# Tile Signals
signal on_selection_enabled
signal on_selection_disabled
signal on_tile_selected(tile: MemoryTile)

# Game Signals
signal on_game_over(moves: int)
signal on_move_made
signal on_pair_made


func _ready() -> void:
	#on_game_over.connect(_test_print)
	pass

func _test_print(a) -> void:
	print("Signal Emitted Successfully.", a)
