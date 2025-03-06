extends Node


const LEVEL_DATA_PATH: String = "res://data/level_data.json"
const TILE_SIZE: int = 32


var _level_data: Dictionary = {}


func _ready() -> void:
	_load_level_data()


func _load_level_data() -> void:
	var file = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	var raw_data = JSON.parse_string(file.get_as_text())
	
	for lns in raw_data.keys():
		var new_level_layout: LevelLayout = _setup_level(lns, raw_data[lns])
		_level_data[lns] = new_level_layout


func _setup_level(_lns: String, raw_level_data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	var raw_tiles: Dictionary = raw_level_data.tiles
	var player_start = raw_level_data.player_start
	
	add_tiles_for_layer(layout, TileLayers.LayerType.FLOOR, raw_tiles.Floor)
	add_tiles_for_layer(layout, TileLayers.LayerType.WALL, raw_tiles.Walls)
	add_tiles_for_layer(layout, TileLayers.LayerType.BOX, raw_tiles.Boxes)
	add_tiles_for_layer(layout, TileLayers.LayerType.TARGET_BOX, raw_tiles.TargetBoxes)
	add_tiles_for_layer(layout, TileLayers.LayerType.TARGET, raw_tiles.Targets)
	
	layout.set_player_start(player_start.x, player_start.y)
	
	return layout


func add_tiles_for_layer(layout: LevelLayout, layer_type: TileLayers.LayerType, tile_coords: Array) -> void:
	for tile_coord in tile_coords:
		layout.add_tile_to_layer(tile_coord.x, tile_coord.y, layer_type)


func get_level_data(ln: String) -> LevelLayout:
	return _level_data[ln]
