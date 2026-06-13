extends Area2D

const CHALLENGE_POPUP_SCENE = preload("res://Scenes/challenge_popup.tscn")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		iniciar_desafio()

func iniciar_desafio():
	get_tree().paused = true
	
	var popup_instance = CHALLENGE_POPUP_SCENE.instantiate()
	get_tree().current_scene.add_child(popup_instance)
	
	# CONEXIÓN CRUCIAL: Cuando la ventana diga que ganamos, ejecutamos '_on_desafio_ganado'
	popup_instance.desafio_completado.connect(_on_desafio_ganado)

func _on_desafio_ganado():
	# 1. Le sumamos un punto al jugador en tu script Global
	Global.puntos += 1 
	
	# 2. Eliminamos el cuadro rojo del mapa para que no se pueda volver a tocar
	queue_free()
