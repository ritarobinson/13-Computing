extends Control
class_name Settings

#Variables
onready var controlButton = $ControlButton
onready var sliderValue = $SensitivitySlider.value
onready var sliderValueTitle = $SensitivitySlider/SliderValue

var control: bool 

#If the save button is pressed, save settings changes and goes to game
func _on_SaveButton_button_up():
	#save the changed controls
	if control == true: #Arrows
		Signals.add_user_signal("arrows_control")
	elif control == false: pass #WASD

	#if the user changes avatar skin, or doesn't
	var avatar = $AvatarButton.text
	if avatar == "Green Avatar": #avatar is to be green
		Signals.add_user_signal("green_avatar")
	elif avatar == "Default Avatar": 
		Signals.add_user_signal("blue_avatar") #default blue
	else: pass
	
	#sets speed sensitivity for player and enemy
	if sliderValue == 120:  	Signals.add_user_signal("120_sensitivity")
	elif sliderValue == 100:	Signals.add_user_signal("100_sensitivity")
	elif sliderValue == 80: 	Signals.add_user_signal("80_sensitivity")
	elif sliderValue == 60: 	Signals.add_user_signal("60_sensitivity")
	elif sliderValue == 40: 	Signals.add_user_signal("40_sensitivity")
	
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World/World.tscn")


#If the control button is pressed..
func _on_ControlButton_button_up():
	if controlButton.pressed == true:
		control = true #Arrows
	elif controlButton.pressed == false:
		control = false #WASD
	else: pass


#Finds the sliders value and sets it as a value
func _on_SensitivitySlider_value_changed(value):
	sliderValue = value
	set_slider_value()


#Sets the slider text so user can see sensitivity value
func set_slider_value():
	if sliderValue == 80:	sliderValueTitle.text = "%s (Default)" % sliderValue
	else:	sliderValueTitle.text = "%s" % sliderValue
