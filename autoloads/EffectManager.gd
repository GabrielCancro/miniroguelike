extends Node

func move_to(node, position):
	var tw = create_tween()
	tw.tween_property(node,"position",position,0.2)

func move_yoyo(node,dir):
	var tw = create_tween()
	var start_pos = node.position
	tw.tween_property(node,"position",start_pos+dir,0.05)
	tw.tween_property(node,"position",start_pos,0.05)
