extends Node


const levels: Dictionary = {
	"0": preload("res://scenes/main/main.tscn"),
	"1": preload("res://scenes/level_01/level_01.tscn"),
	"2": preload("res://scenes/level_02/level_02.tscn"),
	"3": preload("res://scenes/level_03/level_03.tscn")
}


var _selected_level: String


func _ready() -> void:
	Signals.load_level.connect(_load_level)


func _load_level(level: String):
	_selected_level = level
	get_tree().change_scene_to_packed(levels[level])


func get_selected_level() -> String:
	return _selected_level
