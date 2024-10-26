extends Control

func _ready():
	$Node2D/AnimatedSprite2D.play("default")
	
func set_value(value):
	$Node2D/TextureProgressBar.value = value
