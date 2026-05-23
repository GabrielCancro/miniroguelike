extends Control

func _ready() -> void:
	PlayerManager.on_change_stat.connect(update_stats)
	GameManager.on_change_game_state.connect(update_game_state)
	update_stats()

func update_stats():
	%Label.text = ""
	for stat in PlayerManager.data:
		%Label.text += stat+": "+str(PlayerManager.get_stat(stat))+"\n"

func update_game_state(game_state):
	if game_state=="player_turn":
		%Label2.text = "PLAYER TURN"
	else:
		%Label2.text = "ENEMY TURN"
