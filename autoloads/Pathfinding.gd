extends Node

var astar := AStarGrid2D.new()
var tilemap:TileMapLayer

func set_map():
	tilemap = MapManager.tilemap
	var used := tilemap.get_used_rect()

	astar.region = used
	astar.cell_size = Vector2i(16, 16)
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	#
	for cell in tilemap.get_used_cells():
		if !MapManager.is_tile_free(cell.x, cell.y):
			astar.set_point_solid(cell, true)

func get_astar_path(start_tile: Vector2i, end_tile: Vector2i):
	var path = astar.get_id_path(start_tile, end_tile)
	return path
