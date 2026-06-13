extends CharacterBody2D

var speed := 120.0
var jump_velocity := -300.0 # El salto en Godot es negativo (hacia arriba)
var puede_moverse := true 
# Gravedad estándar para Godot 4
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D

func _physics_process(delta: float) -> void:
	# 1. Aplicar Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta
	# 2. Manejar Salto y Movimiento
	if puede_moverse:
		# Lógica de Salto
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = jump_velocity
			# anim.play("Jump") # Descomenta si tienes una animación de salto

		# Movimiento Horizontal
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * speed
			sprite.flip_h = direction < 0
			if is_on_floor():
				anim.play("Walk") # Cambia por el nombre de tu animación de caminar
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			if is_on_floor():
				anim.play("Idle")
	else:
		# Si no puede moverse, se detiene suavemente pero sigue cayendo si está en el aire
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			anim.play("Idle")

	# 3. Ejecutar el movimiento físico
	move_and_slide()

func _input(event):
	if event.is_action_pressed("ui_inspect"): 
		var resource = load("res://Dialogos/dialogoBin.dialogue")
		DialogueManager.show_example_dialogue_balloon(resource, "inicio_tutorial")
