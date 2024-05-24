extends CharacterBody2D
 
@onready var tilemap = get_tree().current_scene.find_child("TileMap")
 
var area : String = "":
	set(value):
		area = value
		%Tile.text = value
 
 
func update_tile():
	var tiledata = tilemap.get_cell_tile_data(0,tilemap.local_to_map(position))
	if tiledata:
		area = tiledata.get_custom_data("Area")
 
func _physics_process(delta):
	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * 100
	move_and_slide()

 
	update_tile()
