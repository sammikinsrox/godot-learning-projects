class_name LevelData


var _level_number: int
var _rows: int
var _columns: int


func _init(level_number: int, rows: int, columns: int) -> void:
	_level_number = level_number
	_rows = rows
	_columns = columns


func get_level_number() -> int:
	return _level_number


func get_rows() -> int:
	return _rows


func  get_columns() -> int:
	return _columns
	

func get_target_pairs() -> int:
	return((_rows * _columns) / 2)


func get_num_tiles() -> int:
	return _rows * _columns
