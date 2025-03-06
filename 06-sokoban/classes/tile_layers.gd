class_name TileLayers

enum LayerType { FLOOR, WALL, TARGET, BOX, TARGET_BOX }

var _floor: Array[Vector2i] = []
var _wall: Array[Vector2i] = []
var _targets: Array[Vector2i] = []
var _boxes: Array[Vector2i] = []
var _target_boxes: Array[Vector2i] = []

var _layer_coords: Dictionary = {
	LayerType.FLOOR: _floor,
	LayerType.WALL: _wall,
	LayerType.TARGET: _targets,
	LayerType.BOX: _boxes,
	LayerType.TARGET_BOX: _target_boxes
}

func add_coord(coord: Vector2i, layer_type: LayerType) -> void:
	# Get the array for the specific layer type
	var layer_array: Array[Vector2i] = _layer_coords[layer_type]
	
	# Add the coordinate to the array
	layer_array.push_back(coord)
	
	# Update the dictionary with the modified array
	_layer_coords[layer_type] = layer_array


func get_tiles_for_layer(layer_type: LayerType) -> Array[Vector2i]:
	return _layer_coords[layer_type] 
