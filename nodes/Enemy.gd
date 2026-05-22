extends Sprite2D

var tile_pos = Vector2i(0,0)
var data = {
	"type":null,
	"hp":null,
	"hpm":null,
	"mov":null,
	"movm":null
}

func _ready() -> void:
	initialize("goblin")

func initialize(code):
	data = EnemyManager.get_enemy_data(code)
	var tx = int((position.x-32)/64)
	var ty = int((position.y-32)/64)
	set_tile_pos(tx, ty)
	EnemyManager.register_enemy(self)

func set_tile_pos(tx,ty):
	look_to_xpos(tx)
	tile_pos = Vector2(tx,ty)
	var new_pos = tile_pos*64 + Vector2(32,32)
	EffectManager.move_to(self, new_pos)
	print("Enemy in ", tile_pos)

func look_to_xpos(xpos):
	if (xpos>tile_pos.x): flip_h = false
	elif (xpos<tile_pos.x): flip_h = true

func add_stat(stat_key, value):
	data[stat_key] += value
	print(stat_key,"->",data[stat_key])
	return data[stat_key]

func get_stat(stat_key):
	return data.get(stat_key, 0)

func restore_mov():
	add_stat("mov",data["movm"]-data["mov"])
