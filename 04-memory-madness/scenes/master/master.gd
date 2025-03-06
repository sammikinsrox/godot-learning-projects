extends CanvasLayer


@onready var main: Control = $Main
@onready var game: Control = $Game
@onready var sound: AudioStreamPlayer = $Sound


func _ready() -> void:
	SignalManager.on_game_exit_pressed.connect(_on_game_exit_pressed)
	SignalManager.on_level_selected.connect(_on_level_selected)
	
	_on_game_exit_pressed()


func _on_game_exit_pressed() -> void:
	show_game(false)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)


func _on_level_selected(_l:int) -> void:
	show_game(true)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)


func show_game(s: bool) -> void:
	game.visible = s
	main.visible = !s
