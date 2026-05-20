extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MapManager.initialize_map_manager($TileMapLayer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
