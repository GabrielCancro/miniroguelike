extends Node

var ENEMIES = []

func register_enemy(node):
	ENEMIES.append(node)

func get_enemy_data(code):
	return {
		"type":code,
		"frame":2,
		"hp":5,
		"hpm":5,
		"mov":8,
		"movm":3,
	}

func move_enemies():
	for enemy in ENEMIES:
		enemy.restore_mov()
		Pathfinding.set_map()
		print("PATH FINDING ",enemy.tile_pos," TO ",PlayerManager.player_node.tile_pos)
		var path = Pathfinding.get_astar_path(enemy.tile_pos, PlayerManager.player_node.tile_pos)
		path.pop_front() #remove start position
		path.pop_back() #remove end position
		print(path)
		while enemy.get_stat("mov")>0:
			if !path: break
			enemy.add_stat("mov",-1)
			var next = path.pop_front()
			enemy.set_tile_pos(next.x, next.y)
			await  get_tree().create_timer(.3).timeout
		print("FINISHED!")
