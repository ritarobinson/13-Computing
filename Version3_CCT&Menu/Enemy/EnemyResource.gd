extends Resource
class_name EnemyResource

#Variables
export var texture: Texture
export var max_health: int
export var health: int
export var speed = 50

func _init():
# warning-ignore:return_value_discarded
	Signals.connect("set_enemy_speed", self, "on_set_enemy_speed")
# warning-ignore:return_value_discarded
	Signals.connect("enemy_speed_sensitivity", self, "on_enemy_speed_sensitivity")


#Called from enemy script in ready func
func on_set_enemy_speed():
	#signals for speed sensitivity, connected from Settings Menu speed/sensitivity slider
	if Signals.has_user_signal("120_sensitivity"):  	on_enemy_speed_sensitivity(75)
	elif Signals.has_user_signal("100_sensitivity"):	on_enemy_speed_sensitivity(62.5)
	elif Signals.has_user_signal("80_sensitivity"): 	on_enemy_speed_sensitivity(50)
	elif Signals.has_user_signal("60_sensitivity"): 	on_enemy_speed_sensitivity(37.5)
	elif Signals.has_user_signal("40_sensitivity"): 	on_enemy_speed_sensitivity(25)


#Sets the enemys speed depending on speed sensitivity
func on_enemy_speed_sensitivity(new_speed):
	speed = new_speed
	Signals.emit_signal("enemy_speed_change", new_speed)
