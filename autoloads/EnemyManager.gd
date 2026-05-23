extends Node

var ENEMIES = []

func register_enemy(node):
	ENEMIES.append(node)

func get_enemy_data(code):
	return {
		"type":code,
		"frame":2,
		"hp":2,
		"hpm":2,
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
			if await try_attack(enemy):
				enemy.add_stat("mov",-999)
				break
			if !path: break
			enemy.add_stat("mov",-1)
			var next = path.pop_front()
			enemy.set_tile_pos(next.x, next.y)
			await get_tree().create_timer(.3).timeout
		await get_tree().create_timer(.3).timeout
	print("FINISHED!")

func try_attack(enemy):
	var dist = enemy.tile_pos.distance_to(PlayerManager.player_node.tile_pos)
	print("try_attack! ",dist)
	if dist==1:
		print("ATTACK!")
		var dir = enemy.tile_pos.direction_to(PlayerManager.player_node.tile_pos)*16
		enemy.look_to_xpos(PlayerManager.player_node.tile_pos.x)
		await get_tree().create_timer(.2).timeout
		await EffectManager.move_yoyo(enemy,dir)
		await get_tree().create_timer(.2).timeout
		PlayerManager.add_stat("hp",-1)
		return true
	return false

func get_enemy_in_pos(tx,ty):
	for enemy in ENEMIES:
		print(enemy.tile_pos," ",Vector2(tx,ty))
		if enemy.tile_pos==Vector2(tx,ty):
			return enemy
	return null
