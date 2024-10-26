extends CanvasLayer

func game_over():
	#emit_signal("game_over")
	$GameOverContainer.visible = true
	$BgMusic.play()

func _on_restart_pressed():
	get_tree().call_deferred("reload_current_scene")


func _on_menu_pressed():
	SceneTransition.change_scene_to_file("res://Assets/Menu/menu.tscn")

func _process(delta):
	$MarginContainer/HBoxContainer/Score.text = str(Global.Gold)
	$HealthBarPlayer.set_value(Global.Health)
	
	if Global.Health <=0:
		game_over()
	
