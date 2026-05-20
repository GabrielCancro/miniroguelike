extends Node

@onready var tilemap: TileMapLayer

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
