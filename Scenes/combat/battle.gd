extends Node2D
 
@onready var bg = $BG
@export_dir var BG_FOLDER
 
var enemy : Enemy = null:
	set(value):
		enemy = value
		if value != null:
			%Enemy.texture = value.texture
 
func _ready():
	load_data()
 
func load_data():
	bg.texture = load(BG_FOLDER+ "/" + Manager.area + ".png")
	enemy = Manager.get_enemy()
