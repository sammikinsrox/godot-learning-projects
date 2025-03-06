extends Node


const PATH: String = "res://assets/glitch/"


func _ready() -> void:
	var dir: DirAccess = DirAccess.open(PATH)
	var image_file_list: ImageFileList = ImageFileList.new()
	
	if dir:
		var files: PackedStringArray = dir.get_files()
		for filename in files:
			image_file_list.add_filename(PATH + filename)
			
	ResourceSaver.save(image_file_list, "res://resources/image_file_list.tres")
