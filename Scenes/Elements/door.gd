extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destinantion_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $Spawn


func _on_body_entered(body):
	if body is Player:
		pass
