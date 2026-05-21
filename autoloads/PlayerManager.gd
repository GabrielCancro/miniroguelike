extends Node

var player_node: CPlayer

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		try_move(0,-1)
	if event.is_action_pressed("down"):
		try_move(0,1)
	if event.is_action_pressed("left"):
		try_move(-1,0)
	if event.is_action_pressed("right"):
		try_move(1,0)

func try_move(mx,my):
	var destine_pos = player_node.tile_pos + Vector2(mx,my)
	var is_tile_free = MapManager.is_tile_free(destine_pos.x, destine_pos.y)
	if is_tile_free:
		player_node.move_tile_to(mx,my)
	else:
		var dir = Vector2(mx,my)*32
		EffectManager.move_yoyo(player_node, dir)
