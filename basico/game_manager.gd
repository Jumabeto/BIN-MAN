extends Node

var puntaje: int = 0

signal puntaje_actualizado(nuevo_valor)

func sumar_puntos(cantidad: int):
	puntaje += cantidad
	puntaje_actualizado.emit(puntaje) # Avisa a la interfaz que el puntaje cambió
	print(puntaje)
