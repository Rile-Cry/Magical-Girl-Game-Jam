extends Control

func _ready():
	$AnimatedSprite2D.scale.x = get_viewport().size.x /640.00
	$AnimatedSprite2D.scale.y = get_viewport().size.y /360.00
	$AnimatedSprite2D.position.x = get_viewport().size.x /2
	$AnimatedSprite2D.position.y = get_viewport().size.y /2
	$AnimatedSprite2D.play("default")
	print(get_viewport().size.x)
	print(get_viewport().size.y)

func _on_start_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Levels/levels.tscn")


func _on_settings_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Settings/settings.tscn")


func _on_credits_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Credits/credits.tscn")
