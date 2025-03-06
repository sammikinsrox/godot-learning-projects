class_name LevelButton extends NinePatchRect


@onready var level_label: Label = $LevelLabel
@onready var check_mark: TextureRect = $CheckMark

var _level_number: String = "1"


func _ready() -> void:
	level_label.text = _level_number
	if ScoreSync.has_level_score(_level_number):
		check_mark.show()


func _process(_delta: float) -> void:
	pass


func set_level_number(level_number: String) -> void:
	_level_number = level_number


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		SignalManager.on_level_selected.emit(_level_number)
