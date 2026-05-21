extends Node2D
class_name CPlayer

var tile_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player_node = self
	set_tile_pos(3,3)

func set_tile_pos(tx,ty):
	tile_pos = Vector2(tx,ty)
	var new_pos = tile_pos*64 + Vector2(32,32)
	EffectManager.move_to(self, new_pos)
	print("Player in ",tile_pos)

func move_tile_to(mx,my):
	set_tile_pos(tile_pos.x+mx,tile_pos.y+my)

func look_to_xpos(xpos):
	if (xpos>tile_pos.x): $Sprite2D.flip_h = false
	elif (xpos<tile_pos.x): $Sprite2D.flip_h = true
