extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MapManager.initialize_map_manager($TileMapLayer)
	$Button.pressed.connect(EnemyManager.move_enemies)
