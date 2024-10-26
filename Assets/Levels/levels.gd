extends Control


func _on_sound_button_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Menu/menu.tscn")


func _on_rotate_button_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Levels/Level0/level_0.tscn")
