extends CharacterBody2D
## Script for controlling the bullets that spawn from towers, this script is specific
## to the Type-A bullet variety.

@export var bullet_damage : int = 1
@export var speed = 1000
var pathName = ""
var target

func _ready() -> void:
	add_to_group("bullets")
	velocity = velocity * speed
	$AnimatedSprite2D.play("default")

func _physics_process(_delta) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body) -> void:
	if body in get_tree().get_nodes_in_group("enemies"):
		#body.queue_free()
		body.Health -= bullet_damage
		body.damage()
		queue_free()
