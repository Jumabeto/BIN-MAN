extends Node

signal vidas_actualizadas(nuevas_vidas)
signal juego_terminado

var vidas_maximas: int = 3
var vidas_actuales: int = 3
var puntos = 0


func restar_vida(cantidad: int = 1):
	vidas_actuales -= cantidad
	vidas_actualizadas.emit(vidas_actuales) # Avisa al letrero de vidas
	
	if vidas_actuales <= 0:
		juego_terminado.emit()
		ir_a_game_over()

func ir_a_game_over():
	# Pausamos el juego para que nada se mueva en el fondo
	get_tree().paused = true
	# Cambiamos a la escena de Game Over (la crearemos en el Paso 4)
	get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
