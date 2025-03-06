extends Node


const DEFAULT_SCORE: float = 0
const SCORES_PATH = "user://score.json"


var _selected_level: String
var _level_scores: Dictionary = { }


func _ready() -> void:
	_read_scores_from_disk()


func _check_and_add(level: String) -> void:
	if not _level_scores.has(level):
		_level_scores[level] = DEFAULT_SCORE


func set_selected_level(level: String) -> void:
	_selected_level = GameManager.get_selected_level()


func set_score_for_level(score: int, level: String):
	print("level ", level)
	_check_and_add(level)
	if score > _level_scores[level]:
		_level_scores[level] = score
		_save_scores_to_disk()


func get_best_score_for_level(level:String) -> int:
	_check_and_add(level)
	return _level_scores[level]


func _save_scores_to_disk():
	var file = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	var score_json_str = JSON.stringify(_level_scores)
	file.store_string(score_json_str)


func _read_scores_from_disk():
	var file = FileAccess.open(SCORES_PATH, FileAccess.READ)
	if not file:
		_save_scores_to_disk()
	else:
		var data = file.get_as_text()
		_level_scores = JSON.parse_string(data)
