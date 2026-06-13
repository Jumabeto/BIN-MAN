extends Label # O cambia a RichTextLabel si ese es tu tipo de nodo

func _ready() -> void:
	# 1. Ponemos el marcador en 0 al iniciar
	text = "Puntaje: 0"
	
	# 2. Nos conectamos a la señal del GameManager de forma segura
	# (Asumiendo que GameManager es un Autoload/Singleton)
	GameManager.puntaje_actualizado.connect(_on_puntaje_actualizado)

func _on_puntaje_actualizado(nuevo_valor: int) -> void:
	# 3. Cada vez que el GameManager avise que cambió el puntaje, el letrero se actualiza solo
	text = "Puntaje: " + str(nuevo_valor)
