extends Button
 
@export var world : PackedScene
 
func _on_pressed():
	get_tree().change_scene_to_packed(world)
