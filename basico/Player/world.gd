extends Node

# Cargamos el archivo de diálogo que escribiste (el de binarios)
const DIALOGO_TUTORIAL = preload("res://Dialogos/dialogoBin.dialogue")

# Cargamos la escena "pequeña" que ya viene dentro del plugin
const SMALL_BALLOON = preload("res://addons/dialogue_manager/example_balloon/small_example_balloon.tscn")

func _ready():
	# Esperamos un momento a que el nivel cargue
	await get_tree().process_frame
	
	# Instanciamos el globo pequeño
	var balloon = SMALL_BALLOON.instantiate()
	add_child(balloon)
	
	# Lo iniciamos pasándole tu recurso y el título de la sección
	balloon.start(DIALOGO_TUTORIAL, "inicio_tutorial")
	
func mostrar_tutorial():
	var jugador = $Player
	var recurso = preload("res://Dialogos/dialogoBin.dialogue")
	
	await DialogueManager.show_example_dialogue_balloon(recurso, "inicio_tutorial")
		
	
func _ready_labels():
	# 1. Aseguramos el estado inicial
	$Label2.show()
	$Label3.hide()
	$Label4.hide()
	
	# 2. Llamamos a la función que hace el intercambio
	intercambiar_con_tiempo()

func intercambiar_con_tiempo():
	# Espera exactamente 5 segundos (puedes cambiar el número)
	await get_tree().create_timer(5.0).timeout
	
	# 3. Hacemos el cambio
	$Label2.hide()
	$Label3.show()
	$Label3.show()
	# Opcional: Imprime en consola para estar seguro de que pasó
	print("Cambiando Label2 por Label3, Label4")
