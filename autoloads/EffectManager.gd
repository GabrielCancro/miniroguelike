extends Node

func move_to(node, position):
	var tw = create_tween()
	tw.tween_property(node,"position",position,0.2)
