extends Node2D

@export var battle_scene : PackedScene 

var encounter_number : int = 100:
	set(value):
		encounter_number = value
		%Encounter.text = str(value)

var area : String = "Mazmorra"
var player_last_position: Vector2 = Vector2(100,100)

var enemy_cache : Dictionary = {}
@export_dir var enemy_folder
 
var encounter : Dictionary = {
	"Mazmorra" : ["000"],
	"Desierto" : ["001"]
}

func _ready():
	randomize()
	encounter_number = randi_range(25,50)
	load_enemy_data()


func change_scene():
	get_tree().change_scene_to_packed(battle_scene)
	encounter_number = randi_range(25,50)
	
	
func save_player_data(player):
	area = player.area
	player_last_position = player.position
	
	

func load_enemy_data():
	var folder = DirAccess.open(enemy_folder)
 
	folder.list_dir_begin()
	var file_name = folder.get_next()
 
	while file_name != "":
 
		enemy_cache[file_name] = load(enemy_folder + "/" + file_name)
 
		file_name = folder.get_next()

func get_enemy(ID = "000") -> Enemy:
	var enemy_file_name = encounter[area][randi() % encounter[area].size()] + ".tres"
 
	return enemy_cache[enemy_file_name]
