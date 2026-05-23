extends Node

var INPUT_ENABLE = true
signal on_change_game_state(turn_of)

func end_turn():
	INPUT_ENABLE = false
	await get_tree().create_timer(.5).timeout
	on_change_game_state.emit("enemy_turn")
	await EnemyManager.move_enemies()
	await get_tree().create_timer(.5).timeout
	PlayerManager.add_stat("mov", 999)
	INPUT_ENABLE = true
	on_change_game_state.emit("player_turn")
