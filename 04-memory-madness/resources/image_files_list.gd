class_name ImageFileList extends Resource


@export var file_names: Array[String]


func add_filename(filename: String) -> void:
	if not '.import' in filename:
		file_names.append(filename)
		
		
func get_filenames() -> Array:
	return file_names
