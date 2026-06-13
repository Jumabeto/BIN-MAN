extends Node2D

const VELOCIDAD = 60
var direccion = 1

@onready var derecha: RayCast2D = $derecha
@onready var izquierda: RayCast2D = $izquierda
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta: float) -> void:
	# Manejo de rebote con RayCasts
	if izquierda.is_colliding():
		direccion = 1
		animated_sprite.flip_h = true
	elif derecha.is_colliding():
		direccion = -1
		animated_sprite.flip_h = false
	
	position.x += direccion * VELOCIDAD * delta

# --- ESTO ES LO QUE DEBES AÑADIR ---
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		# Cambia "res://menu.tscn" por la ruta real de tu menú
		get_tree().change_scene_to_file("res://options.tscn")
		


func _on_zona_de_muerte_body_entered(body: Node2D) -> void:
	# Comprobamos si el objeto que entró es el jugador
	if body.name == "Player":
		# Usamos la variable Global que configuramos en el script global
		Global.restar_vida(1)
