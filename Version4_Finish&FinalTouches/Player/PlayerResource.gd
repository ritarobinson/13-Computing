extends Resource
class_name PlayerResource

#Variables
export var speed = 80
var health: int
var changing_speed: bool
var slower_speed = 55

func _init():
# warning-ignore:return_value_discarded
	Signals.connect("set_speed", self, "on_set_speed")
# warning-ignore:return_value_discarded
	Signals.connect("player_health", self, "on_player_health")
# warning-ignore:return_value_discarded
	Signals.connect("speed_sensitivity", self, "on_speed_sensitivity")
	
	#signals for speed sensitivity
	if Signals.has_user_signal("120_sensitivity"):  	on_speed_sensitivity(120)
	elif Signals.has_user_signal("100_sensitivity"):	on_speed_sensitivity(100)
	elif Signals.has_user_signal("80_sensitivity"): 	on_speed_sensitivity(80)
	elif Signals.has_user_signal("60_sensitivity"): 	on_speed_sensitivity(60)
	elif Signals.has_user_signal("40_sensitivity"): 	on_speed_sensitivity(40)


#Called from player script in ready func
func on_set_speed():
	changing_speed = true


#Called from func in world, is emitted when player health = 2
func on_player_health(player_health):
	health = player_health
	change_speed()


#Sets the new speed and slowerspeed depending on speed sensitivity
func on_speed_sensitivity(new_speed):
	speed = new_speed
	if speed == 120:
		slower_speed = 95
	elif speed == 100:
		slower_speed = 75
	elif speed == 80:
		slower_speed = 55
	elif speed == 60:
		slower_speed = 35
	elif speed == 40:
		slower_speed = 15


#Changes speed if player is instanced, and player health = 2
func change_speed():
	if changing_speed == true:
		if health == 2:
			speed = slower_speed
			Signals.emit_signal("speed_change", speed)
