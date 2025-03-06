extends Node2D


const SOURCE_ID = 0


@onready var tile_layers: Node = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/Floors
@onready var wall_tiles: TileMapLayer = $TileLayers/Wall
@onready var target_tiles: TileMapLayer = $TileLayers/Targets
@onready var box_tiles: TileMapLayer = $TileLayers/Boxes
@onready var player: AnimatedSprite2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var hud: Hud = $CanvasLayer2/Hud
@onready var game_over_ui: GameOver = $CanvasLayer2/GameOverUI

var _total_moves: int = 0
var _player_tile: Vector2i = Vector2i.ZERO
var _game_over: bool = false



func _ready() -> void:
	setup_level()


func _process(_delta: float) -> void:
	var move_direction: Vector2i = Vector2i.ZERO
	
	if Input.is_action_just_pressed("reload"):
		setup_level()
	elif Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
		
	if _game_over:
		return
		
	if Input.is_action_just_pressed("right"):
		move_direction = Vector2i.RIGHT
		player.flip_h = false
	elif Input.is_action_just_pressed("left"):
		move_direction = Vector2i.LEFT
		player.flip_h = true
	elif Input.is_action_just_pressed("up"):
		move_direction = Vector2i.UP
	elif Input.is_action_just_pressed("down"):
		move_direction = Vector2.DOWN

	if move_direction != Vector2i.ZERO:
		player_move(move_direction)

func clear_tiles() -> void:
	for tile_layer in tile_layers.get_children():
		tile_layer.clear()


func setup_level() -> void:
	var level_number: String = GameManager.get_level_selected()
	var layout: LevelLayout = LevelData.get_level_data(level_number)
	
	_total_moves = 0
	
	clear_tiles()
	setup_layer(TileLayers.LayerType.FLOOR, floor_tiles, layout)
	setup_layer(TileLayers.LayerType.WALL, wall_tiles, layout)
	setup_layer(TileLayers.LayerType.TARGET, target_tiles, layout)
	setup_layer(TileLayers.LayerType.BOX, box_tiles, layout)
	setup_layer(TileLayers.LayerType.TARGET_BOX, target_tiles, layout)
	
	place_player_on_tile(layout.get_player_start())
	
	move_camera()
	
	hud.new_game(level_number)
	game_over_ui.new_game()

	_game_over = false

func get_atlas_for_layer_type(layer_type:TileLayers.LayerType) -> Vector2i:
	match layer_type:
		TileLayers.LayerType.FLOOR:
			return Vector2(randi_range(3,8), 0)
		TileLayers.LayerType.WALL:
			return Vector2i(2, 0)
		TileLayers.LayerType.BOX:
			return Vector2i(1, 0)
		TileLayers.LayerType.TARGET_BOX:
			return Vector2i(0, 0)
		TileLayers.LayerType.TARGET:
			return Vector2i(9, 0)
	return Vector2i.ZERO


func add_tile(layer_type: TileLayers.LayerType, tile_coord: Vector2i, map_layer: TileMapLayer) -> void:
	var atlas_coord: Vector2i = get_atlas_for_layer_type(layer_type)
	map_layer.set_cell(tile_coord, SOURCE_ID, atlas_coord)


func setup_layer(layer_type: TileLayers.LayerType, map_layer: TileMapLayer, level_layout: LevelLayout) -> void:
	var tiles_array: Array[Vector2i] = level_layout.get_tiles_for_layer(layer_type)
	for tile_coord in tiles_array:
		add_tile(layer_type, tile_coord, map_layer)


func move_camera() -> void:
	var tilemap_rect: Rect2i = floor_tiles.get_used_rect()
	var tilemap_width_x: float = tilemap_rect.size.x * LevelData.TILE_SIZE
	var tilemap_width_y: float = tilemap_rect.size.y * LevelData.TILE_SIZE
	var mid_x: float = tilemap_width_x / 2 + (tilemap_rect.position.x * LevelData.TILE_SIZE)
	var mid_y: float = tilemap_width_y / 2 + (tilemap_rect.position.y * LevelData.TILE_SIZE)
	
	camera_2d.position = Vector2(mid_x, mid_y)


func place_player_on_tile(tile_coord: Vector2i) -> void:
	var new_position: Vector2 = Vector2(tile_coord.x * LevelData.TILE_SIZE, tile_coord.y * LevelData.TILE_SIZE) + tile_layers.position
	player.position = new_position
	_player_tile = tile_coord


func player_move(direction: Vector2i) -> void:
	var new_tile: Vector2i = _player_tile + direction
	var can_move: bool = true
	var box_seen: bool = false
	
	if cell_is_wall(new_tile):
		can_move = false
		
	if cell_is_box(new_tile):
		box_seen = true
		can_move = box_can_move(new_tile, direction)
		
	if can_move:
		_total_moves += 1
		hud.set_move_label(_total_moves)
		if box_seen:
			move_box(new_tile, direction)
		place_player_on_tile(new_tile)
		check_game_state()
		
	


func cell_is_wall(cell: Vector2i) -> bool:
	return cell in wall_tiles.get_used_cells()
	

func cell_is_box(cell: Vector2i) -> bool:
	return cell in box_tiles.get_used_cells()


func cell_is_empty(cell: Vector2i) -> bool:
	return !cell_is_box(cell) and !cell_is_wall(cell)


func box_can_move(box_tile: Vector2i, direction: Vector2i) -> bool:
	return cell_is_empty(box_tile + direction)


func move_box(box_tile: Vector2i, direction: Vector2i) -> void:
	var destination: Vector2i = box_tile + direction
	box_tiles.erase_cell(box_tile)
	
	if destination in target_tiles.get_used_cells():
		box_tiles.set_cell(destination, SOURCE_ID, get_atlas_for_layer_type(TileLayers.LayerType.TARGET_BOX))
	else:
		box_tiles.set_cell(destination, SOURCE_ID, get_atlas_for_layer_type(TileLayers.LayerType.BOX))

func check_game_state() -> void:
	for t in target_tiles.get_used_cells():
		if not cell_is_box(t):
			return
	print("Game Over")
	_game_over = true
	game_over_ui.game_over(GameManager.get_level_selected(), _total_moves)
	ScoreSync.level_completed(GameManager.get_level_selected(), _total_moves)
