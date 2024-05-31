extends CharacterBody2D
class_name Player

@export var allowed_maps : Array = ["CaminoSantuario", "Mazmorra"]

@onready var tilemap = get_tree().current_scene.find_child("TileMap")
@onready var anim_sprite = $AnimatedSprite2D
@onready var camera = $Camera2D  # Añadimos la referencia a la cámara

var area : String = "":
	set(value):
		area = value
		%Tile.text = value

var step_size : int = 7

var distance_in_pixel : float = 0.0:
	set(value):
		distance_in_pixel = value
		var step = distance_in_pixel / step_size

		%Distance.text = "%d" % step

		if step >= Manager.encounter_number:
			set_physics_process(false)
			
			Manager.save_player_data(self)
			Manager.change_scene()

var last_direction : Vector2 = Vector2.ZERO

func _ready():
	position = Manager.player_last_position
	# Inicializamos distance_in_pixel para los mapas permitidos
	if get_tree().current_scene.name in allowed_maps:
		distance_in_pixel = 0.0

func update_tile():
	if get_tree().current_scene.name in allowed_maps:
		var tiledata = tilemap.get_cell_tile_data(0, tilemap.local_to_map(position))
		if tiledata:
			area = tiledata.get_custom_data("Area")

func _physics_process(delta):
	var initial_position = position
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * 100
	
	move_and_slide()
	
	# Solo actualizamos distance_in_pixel en los mapas permitidos
	if get_tree().current_scene.name in allowed_maps:
		distance_in_pixel += position.distance_to(initial_position)
		check_for_encounter()
		update_tile()

	update_animation(input_vector)

func update_animation(input_vector):
	if input_vector == Vector2.ZERO:
		# Reproduce la animación idle correspondiente a la última dirección
		if last_direction.x > 0:
			anim_sprite.play("idle_right")
		elif last_direction.x < 0:
			anim_sprite.play("idle_left")
		elif last_direction.y > 0:
			anim_sprite.play("idle_down")
		elif last_direction.y < 0:
			anim_sprite.play("idle_up")
	else:
		# Actualiza la última dirección basada en el input actual
		last_direction = input_vector
		if input_vector.x > 0:
			anim_sprite.play("walk_right")
		elif input_vector.x < 0:
			anim_sprite.play("walk_left")
		elif input_vector.y > 0:
			anim_sprite.play("walk_down")
		elif input_vector.y < 0:
			anim_sprite.play("walk_up")

func check_for_encounter():
	# Aquí va la lógica de los encuentros aleatorios
	var step = distance_in_pixel / step_size

	%Distance.text = "%d" % step

	if step >= Manager.encounter_number:
		set_physics_process(false)

		Manager.save_player_data(self)
		Manager.change_scene()
