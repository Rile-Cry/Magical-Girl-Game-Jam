extends Button

signal upgrade_power
signal upgrade_range
signal upgrade_speed
enum Type {
	UPGRADE_POWER,
	UPGRADE_RANGE,
	UPGRADE_SPEED,
}
@export var current_type : Type = Type.UPGRADE_RANGE

func _on_pressed():
	ButtonClickSound.button_click()
	match current_type:
		Type.UPGRADE_POWER:
			emit_signal("upgrade_power")
		Type.UPGRADE_RANGE:
			emit_signal("upgrade_range")
		Type.UPGRADE_SPEED:
			emit_signal("upgrade_speed")
