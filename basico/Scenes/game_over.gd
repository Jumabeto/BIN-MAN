extends Control

func _on_button_pressed() -> void:
	# 1. Reestablecemos los valores del script global antes de salir
	Global.vidas_actuales = Global.vidas_maximas
	Global.puntos = 0 # Opcional: Reinicia el marcador de puntos si quieres
	
	# 2. OBLIGATORIO: Quitamos la pausa del motor de juego.
	# Si no haces esto, volverás al menú pero todo el proyecto seguirá congelado.
	get_tree().paused = false
	
	# 3. Cambiamos a la escena del menú principal
	# Revisa en tu sistema de archivos si la ruta exacta es así (ojo con mayúsculas/minúsculas)
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
