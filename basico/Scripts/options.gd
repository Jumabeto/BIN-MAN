extends Control

func _on_nivel1_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/wolrd2.tscn")
	
func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
