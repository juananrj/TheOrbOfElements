extends Button

@onready var start_level = preload("res://Scenes/rutes/inicio.tscn") as PackedScene

func _on_pressed():
	get_tree().change_scene_to_packed(start_level)
