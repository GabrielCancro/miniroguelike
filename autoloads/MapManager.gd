extends Node

@onready var tilemap: TileMapLayer
const TILE_DEF = {
	"a1x0":{"type":"wall", "walkeable": false},
	"a1x1":{"type":"floor", "walkeable": true}
}

func initialize_map_manager(_tile_map):
	tilemap = _tile_map

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = get_viewport().get_mouse_position()
		var tile_pos = tilemap.local_to_map(mouse_pos)
		is_tile_free(tile_pos.x, tile_pos.y)
#
#func _process(delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#if !tilemap: return 
		#var mouse_pos = get_viewport().get_mouse_position()
#
		## Convertir posición global -> celda del tilemap
		#var cell = tilemap.local_to_map(mouse_pos)
#
		#print("Cell:", cell)
#
		## Ver si hay tile
		#var source_id = tilemap.get_cell_source_id(cell)
#
		#if source_id == -1:
			#print("No hay tile")
			#return
#
		## Datos del tile
		#var atlas_coords = tilemap.get_cell_atlas_coords(cell)
		#var alternative = tilemap.get_cell_alternative_tile(cell)
#
		#print("Source:", source_id)
		#print("Atlas:", atlas_coords)
		#print("Alternative:", alternative)


func is_tile_free(tx,ty):
	var tile_pos = Vector2(tx,ty)
	var source_id = tilemap.get_cell_source_id(tile_pos)
	if source_id == -1:
		print("No hay tile")
		return false
	var atlas_coords = tilemap.get_cell_atlas_coords(tile_pos)
	var atlas_key = "a"+str(atlas_coords.x)+"x"+str(atlas_coords.y)
	#print(tile_pos,"->",atlas_key,">",source_id,": ",atlas_key in FREE_TILES)
	if atlas_key in TILE_DEF:
		return TILE_DEF[atlas_key]["walkeable"]
	else:
		return false
