extends StaticBody2D

const BULLET : PackedScene = preload("res://Assets/Towers/BulletA/bullet_a.tscn")
var BulletContainer : Node
var BulletTimer : Timer
var ButtonRange : Button
var ButtonSpeed : Button
var ButtonPower : Button
var Marker : Marker2D
var RangeArea : CollisionShape2D
var bullet_damage : int = 10
var can_fire : bool = true
var current_target = null
var fire_delay : float = 5.0
var range_shape : CircleShape2D = CircleShape2D.new()
var path_name : String
var targets : Array = []
var upgrade_power_amount : int = 1
var upgrade_range_amount : int = 15
var upgrade_speed_amount : float = 0.2

func _ready() -> void:
	BulletContainer = $BulletContainer
	BulletTimer = $BulletTimer
	ButtonPower = $Upgrade/Upgrade/HBoxContainer/Power
	ButtonRange = $Upgrade/Upgrade/HBoxContainer/Range
	ButtonSpeed = $Upgrade/Upgrade/HBoxContainer/Speed
	Marker = $Marker2D
	RangeArea = $Area2D/CollisionShape2D
	
	range_shape.radius = 300
	RangeArea.shape = range_shape
	
	BulletTimer.connect("timeout", _on_bullet_timer_timeout)
	ButtonPower.connect("upgrade_power", _on_power_upgraded)
	ButtonRange.connect("upgrade_range", _on_range_upgraded)
	ButtonSpeed.connect("upgrade_speed", _on_speed_upgraded)

func _physics_process(delta) -> void:
	_attack_enemies()
	_reset_timer()

func _attack_enemies() -> void:
	if current_target != null and can_fire:
		#look_at(current_target.global_position)
		
		var tpos = current_target.global_position
		var pos = global_position
		look_at(current_target.global_position)
		var rot = rad_to_deg((tpos - pos).angle())

		if(rot >= -90 and rot <= 90):
			$Sprite2D.flip_h = true
			$Sprite2D.flip_v = false
		else:
			$Sprite2D.flip_h = true
			$Sprite2D.flip_v = true
	
		var Bullet = BULLET.instantiate()
		Bullet.global_position = Marker.global_position
		Bullet.velocity = (Marker.global_position - global_position).normalized()
		Bullet.bullet_damage = bullet_damage
		#get_node("BulletContainer").add_child(tempBullet)
		BulletContainer.call_deferred("add_child", Bullet)
		can_fire = false

func _reset_timer() -> void:
	if not can_fire and BulletTimer.is_stopped():
		BulletTimer.start(fire_delay)

func _on_bullet_timer_timeout() -> void:
	can_fire = true
	BulletTimer.stop()

func _on_area_2d_body_entered(body) -> void:
	var enemies : Array = get_tree().get_nodes_in_group("enemies")
	if body in enemies:
		targets.append(body)
	
	if not targets.is_empty():
		for target in targets:
			if current_target == null:
				current_target = target
			elif (position.distance_to(current_target.position)
					> position.distance_to(target.position)):
				current_target = target

func _on_area_2d_body_exited(body) -> void:
	_remove_enemy(body)

func _on_enemy_killed(body) -> void:
	if body in targets:
		_remove_enemy(body)

func _remove_enemy(body) -> void:
	var target : int = targets.find(body)
	if target != -1:
		targets.remove_at(target)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_mask == 1:
		var towerPath = get_tree().get_root().get_node("Level0/Towers")
		for i in towerPath.get_child_count():
			if towerPath.get_child(i).name != self.name:
				towerPath.get_child(i).get_node("Upgrade/Upgrade").hide()
		get_node("Upgrade/Upgrade").visible = !get_node("Upgrade/Upgrade").visible
		get_node("Upgrade/Upgrade").global_position = self.position + Vector2(-572,81)

func _on_power_upgraded():
	bullet_damage += upgrade_power_amount

func _on_range_upgraded():
	range_shape.radius += upgrade_range_amount
	RangeArea.shape = range_shape

func _on_speed_upgraded():
	if fire_delay > 0.5:
		fire_delay -= upgrade_speed_amount
