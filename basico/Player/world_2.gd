extends Node
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	$%Label.text = "Puntos: " + str(Global.puntos)
# Esta función se genera al conectar la señal 'body_entered' de tu Area2D (Killzone)
func _on_killzone_body_entered(body: Node2D) -> void:
	# Esto imprimirá en la consola de Godot para avisarte si el abismo funciona
	print("Detectado en el vacío: ", body.name) 
	
	# Si lo que cayó es el personaje principal
	if body.name == "Player":
		# Llamamos al script Global para quitarle todas las vidas y mandarlo a Game Over
		Global.restar_vida(Global.vidas_actuales)
