extends Camera2D

@export var shake_amount: float = 5

@onready var shaker_timer: Timer = $ShakerTimer

func _ready() -> void:
	SignalManager.on_player_hit.connect(_on_player_hit)
	SignalManager.on_game_over.connect(_on_game_over)
	set_process(false)


func _process(_delta: float) -> void:
	offset = _get_random_offset()


func _on_game_over() -> void:
	_reset_camera()


func _reset_camera() -> void:
	set_process(false)
	offset = Vector2.ZERO


func _on_player_hit(_lives: int) -> void:
	set_process(true)
	shaker_timer.start()


func _on_shaker_timer_timeout() -> void:
	_reset_camera()


func _get_random_offset() -> Vector2:
	return Vector2(randf_range(-shake_amount, shake_amount), randf_range(-shake_amount, shake_amount))
