class_name Scorer extends Node


@onready var reveal_timer: Timer = $RevealTimer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


var _selections: Array[MemoryTile]
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0


func _ready() -> void:
	SignalManager.on_tile_selected.connect(_on_tile_selected)
	SignalManager.on_game_exit_pressed.connect(_on_game_exit_pressed)


func _on_tile_selected(t: MemoryTile) -> void:
	t.reveal(true)
	SoundManager.play_tile_click(audio_stream_player)
	_selections.append(t)
	_check_pair_made()


func _check_pair_made() -> void:
	if _selections.size() != 2:
		return
	
	reveal_timer.start()
	SignalManager.on_selection_disabled.emit()
	_moves_made += 1
	
	if _selections_are_pair():
		_kill_tiles()
		SignalManager.on_pair_made.emit()
	SignalManager.on_move_made.emit()


func _selections_are_pair() -> bool:
	return _selections[0].matches_other_tile(_selections[1])


func _kill_tiles() -> void:
	for tile: MemoryTile in _selections:
		tile.kill_on_success()	
	_pairs_made += 1
	SoundManager.play_sound(audio_stream_player, SoundManager.SOUND_SUCCESS)


func _on_game_exit_pressed() -> void:
	reveal_timer.stop()


func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0


func _check_game_over() -> void:
	if _target_pairs == _pairs_made:
		SignalManager.on_game_over.emit(_moves_made)


func _on_timer_timeout() -> void:
	if not _selections_are_pair():
		for selection in _selections:
			selection.reveal(false)
	_selections.clear()
	_check_game_over()
	SignalManager.on_selection_enabled.emit()
