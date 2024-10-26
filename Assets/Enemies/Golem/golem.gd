extends CharacterBody2D

@export var speed : int = 100
var Health = 15
var MaxHealth = 15

func _ready():
	add_to_group("enemies")
	$SoundAttack.play()
	$AnimatedSprite2D.play("Run")
	$Node2D/HealthBarEnemy.set_max_value(MaxHealth)
	
func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() ==1:
		#queue_free()
		attack()
	
	$Node2D/HealthBarEnemy.set_value(Health)
	
	if Health <= 0:
		destroy_enemy()
		

func destroy_enemy():
	if not $SoundDead.is_playing():
		$AnimatedSprite2D.play("Dead Hit")
		$SoundDead.play()
	await get_tree().create_timer(0.8).timeout
	get_parent().get_parent().queue_free()
	Global.Gold += 100
	
func damage():
	if not $SoundDamage.is_playing():
		$AnimatedSprite2D.play("Hit")
		$SoundDamage.play()
	await get_tree().create_timer(0.8).timeout
	$AnimatedSprite2D.play("Run")
	
func attack():
	if not $SoundAttack.is_playing():
		$AnimatedSprite2D.play("Attack")
		$SoundAttack.play()
	await get_tree().create_timer(0.8).timeout
	get_parent().get_parent().queue_free()
	Global.Health -= 10
	
