extends Node2D

@onready var path = preload("res://Assets/Routes/Route0/route_0.tscn")

func _on_timer_timeout():
	var tempPath = path.instantiate()
	$PathSpawner.add_child(tempPath)
