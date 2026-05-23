extends Node

var player_node: CPlayer
var data = {
	"hp":7,
	"hpm":7,
	"mov":3,
	"movm":3,
	"str":3,
	"dex":3,
	"obs":3,
	"int":3
}

signal on_change_stat

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if !GameManager.INPUT_ENABLE: return
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
	player_node.look_to_xpos(destine_pos.x)
	var is_tile_free = MapManager.is_tile_free(destine_pos.x, destine_pos.y)
	if check_object(destine_pos.x,destine_pos.y):
		add_stat("mov",-get_stat("mov"))
		GameManager.end_turn()
	elif is_tile_free:
		player_node.move_tile_to(mx,my)
		add_stat("mov",-1)
		if get_stat("mov")<=0: 
			GameManager.end_turn()
	else:
		var dir = Vector2(mx,my)*16
		EffectManager.move_yoyo(player_node, dir)

func check_object(tx,ty):
	var enemy = EnemyManager.get_enemy_in_pos(tx,ty)
	if enemy:
		var dir = (enemy.tile_pos-player_node.tile_pos)*16
		EffectManager.move_yoyo(player_node,dir)
		enemy.add_stat("hp",-1)
		return true
	return false

func add_stat(key,val):
	data[key] += val
	if key+"m" in data:
		data[key] = min(data[key],data[key+"m"])
	on_change_stat.emit()

func get_stat(key):
	return data[key]
