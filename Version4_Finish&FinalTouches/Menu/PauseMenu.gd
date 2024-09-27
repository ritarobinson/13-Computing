extends Control

#Variables
export var tutorial_scene : PackedScene
var is_paused = false setget set_is_paused

func _ready():
	#connecting pause button signal
# warning-ignore:return_value_discarded
	Signals.connect("paused_scene", self, "on_paused_scene")


#If pause button is pressed in world scene,
func on_paused_scene():
	#pause scene
	self.is_paused = !is_paused


#If player preses esc(pause assigned key),
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		Signals.emit_signal("esc_pause")
		#pause scene by Esc key
		self.is_paused = !is_paused


#When scene is paused..
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


#Resumes game if player clicks resume button
func _on_Resume_focus_entered():
	self.is_paused = false
	Signals.emit_signal("unpaused")


#If player presses 'restart',
func _on_Restart_focus_entered():
	#makes sure they want to restart
	$Check.visible = true


func _on_Quit_focus_entered():
	get_tree().quit()


func _on_HowToPlay_focus_entered():
	$Tutorial.visible = true


#If they want to continue to restart game,
func _on_ContinueButton_focus_entered():
	#restarts game
	$Check.visible = false
	self.is_paused = false
	Signals.emit_signal("unpaused")
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
