extends Label

func _ready() -> void:
	# Al iniciar, toma el valor que guarde el script Global
	text = "Vidas: " + str(Global.vidas_actuales)
	# Se conecta de forma segura para escuchar cuando Global reste vidas
	Global.vidas_actualizadas.connect(_on_vidas_actualizadas)

func _on_vidas_actualizadas(nuevas_vidas: int):
	text = "Vidas: " + str(nuevas_vidas)
