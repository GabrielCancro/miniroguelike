extends Node

@onready var tilemap: TileMapLayer
const FREE_TILES = ["a2x1"]

func initialize_map_manager(_tile_map):
	tilemap = _tile_map

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if !tilemap: return 
		var mouse_pos = get_viewport().get_mouse_position()

		# Convertir posición global -> celda del tilemap
		var cell = tilemap.local_to_map(mouse_pos)

		print("Cell:", cell)

		# Ver si hay tile
		var source_id = tilemap.get_cell_source_id(cell)

		if source_id == -1:
			print("No hay tile")
			return

		# Datos del tile
		var atlas_coords = tilemap.get_cell_atlas_coords(cell)
		var alternative = tilemap.get_cell_alternative_tile(cell)

		print("Source:", source_id)
		print("Atlas:", atlas_coords)
		print("Alternative:", alternative)


func cs(tx,ty):
	var cell = tilemap.get_cell_source_id(Vector2(tx,ty))
	var source_id = tilemap.get_cell_source_id(cell)
	if source_id == -1:
		return false
		print("No hay tile")
		return
	var atlas_coords = tilemap.get_cell_atlas_coords(cell)
	var atlas_key = "a"+str(atlas_coords.x)+"x"+str(atlas_coords.x)
	if atlas_key in FREE_TILES:
		return true
	else:
		return false
