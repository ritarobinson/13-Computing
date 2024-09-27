extends Control

#Variables
export var game_scene : PackedScene
export var settings_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#If start button is pressed, change the game scene to the game world
func _on_StartButton_focus_entered():
# warning-ignore:return_value_discarded
	get_tree().change_scene(game_scene.resource_path)


#If the settings button is pressed, change the game scene to settings menu
func _on_SettingsButton_focus_entered():
# warning-ignore:return_value_discarded
	get_tree().change_scene(settings_scene.resource_path)


#If the How To Play button is pressed, show tutorial scene
func _on_TutorialButton_focus_entered():
	$Tutorial.visible = true
