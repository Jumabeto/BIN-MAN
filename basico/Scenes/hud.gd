extends CanvasLayer



func _ready() -> void:
	actualizar_interfaz_puntaje(Global.puntaje)
	Global.puntaje_actualizado.connect(actualizar_interfaz_puntaje)

func actualizar_interfaz_puntaje(nuevo_valor: int) -> void:
	$LabelPuntaje.text = str("Puntos: ", Global.puntos)
