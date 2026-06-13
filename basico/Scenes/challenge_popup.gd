extends CanvasLayer

# Señales para avisar si el jugador ganó o falló
signal desafio_completado
signal desafio_fallido

var respuesta_correcta: int = 0
var tipo_desafio: String = "" # "b2d" (binario a decimal) o "d2b" (decimal a binario)


@onready var label_pregunta = $PanelContainer/VBoxContainer/LabelPregunta
@onready var entrada_respuesta = $PanelContainer/VBoxContainer/HBoxContainer/EntradaRespuesta
@onready var label_feedback = $PanelContainer/VBoxContainer/LabelFeedback

func _ready() -> void:
	# Esperamos un frame para que todos los hijos se carguen correctamente
	await get_tree().process_frame
	
	generar_desafio()
	entrada_respuesta.grab_focus()
func generar_desafio():
	# Decidir aleatoriamente si es B2D o D2B (50/50)
	if randi() % 2 == 0:
		tipo_desafio = "b2d"
		var numero_decimal = randi_range(1, 15) # Números sencillos del 1 al 15
		# Convertimos el decimal a string binario
		var binario_str = String.num_int64(numero_decimal, 2)
		label_pregunta.text = "Convertir el binario: " + binario_str + " -> Decimal:"
		respuesta_correcta = numero_decimal
	else:
		tipo_desafio = "d2b"
		var numero_decimal = randi_range(1, 15)
		# La respuesta correcta ahora se espera en binario (como string)
		label_pregunta.text = "Convertir el decimal: " + str(numero_decimal) + " -> Binario:"
		# Guardamos la respuesta correcta en formato binario para comparar después
		respuesta_correcta = numero_decimal # Guardamos el decimal, lo convertimos al chequear

	label_feedback.text = "" # Limpiamos feedback anterior
	label_feedback.add_theme_color_override("font_color", Color.WHITE)

func _on_boton_enviar_pressed() -> void:
	validar_respuesta()

func _on_entrada_respuesta_text_submitted(new_text: String) -> void:
	validar_respuesta() # También funciona al presionar Enter

func validar_respuesta():
	var texto_jugador = entrada_respuesta.text.strip_edges()
	
	if texto_jugador == "":
		label_feedback.text = "¡Escribe algo primero!"
		return

	var es_correcta = false

	if tipo_desafio == "b2d":
		if texto_jugador.is_valid_int():
			if int(texto_jugador) == respuesta_correcta:
				es_correcta = true
	else:
		var binario_correcto_str = String.num_int64(respuesta_correcta, 2)
		if texto_jugador == binario_correcto_str:
			es_correcta = true

	if es_correcta:
		label_feedback.text = "¡CORRECTO!"
		label_feedback.add_theme_color_override("font_color", Color.GREEN)
		
		# SOLUCIÓN DEFINITIVA: Despausamos el juego AQUÍ mismo.
		# Como la ventana sigue abierta, el jugador todavía no se puede mover 
		# (porque la ventana le quita el foco al teclado), pero el tiempo ya fluye.
		get_tree().paused = false 
		
		# Ahora el temporizador funcionará al 100% sin trabarse
		await get_tree().create_timer(1.0).timeout 
		
		# Avisamos al cuadro rojo para que te sume el punto y se elimine
		desafio_completado.emit()
		
		# Cerramos la ventana
		queue_free()
	else:
		label_feedback.text = "Incorrecto. Intenta de nuevo."
		label_feedback.add_theme_color_override("font_color", Color.RED)
		entrada_respuesta.clear()
		entrada_respuesta.grab_focus()
func cerrar():
	# Quitamos la pausa del motor de juego para que el jugador vuelva a moverse
	get_tree().paused = false 
	queue_free() # Borra esta ventana de la pantalla	
