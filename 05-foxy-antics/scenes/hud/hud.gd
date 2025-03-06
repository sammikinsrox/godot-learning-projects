extends Control


@onready var score_label: Label = $MarginContainer/TopSection/ScoreLabel
@onready var hearts_container: HBoxContainer = $MarginContainer/TopSection/HeartsContainer
@onready var color_rect: ColorRect = $ColorRect
@onready var level_complete_container: VBoxContainer = $ColorRect/LevelCompleteContainer
@onready var game_over_container: VBoxContainer = $ColorRect/GameOverContainer
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var continue_timer: Timer = $ContinueTimer


var _hearts: Array
var _game_over: bool = false
var _can_continue: bool = false


func _ready() -> void:
	_on_score_updated(ScoreManager.get_score())
	_hearts = hearts_container.get_children()
	SignalManager.on_player_hit.connect(_on_player_hit)
	SignalManager.on_level_started.connect(_on_player_hit)
	SignalManager.on_game_over.connect(_on_game_over)
	SignalManager.on_score_updated.connect(_on_score_updated)
	SignalManager.on_level_complete.connect(_on_level_complete)


func _process(_delta: float) -> void:
	if _game_over and Input.is_action_just_pressed("shoot"):
			GameManager.load_main_scene()
	
	if _can_continue and Input.is_action_just_pressed("shoot") and level_complete_container.visible:
				GameManager.load_next_level_scene()


func _on_score_updated(score: int):
	score_label.text = "%00000d" % [score]

func _on_player_hit(lives: int) -> void:
	for life in range(_hearts.size()):
		_hearts[life].visible = lives > life


func _on_game_over() -> void:
	if _game_over or _can_continue:
		return
		
	_game_over = true
	_show_hud()
	game_over_container.show()
	SoundManager.play_clip(sound, SoundManager.SOUND_GAMEOVER)


func _show_hud() -> void:
	color_rect.show()
	continue_timer.start()


func _on_level_complete() -> void:
	_show_hud()
	level_complete_container.show()


func _on_continue_timer_timeout() -> void:
	_can_continue = true
