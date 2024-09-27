extends StaticBody2D

#Variables
var state = "normal"
var player_detected = false
var all_items_collected = false

#Checking states of item, changing appropriatly
func _process(_delta):
	if Signals.has_user_signal("all_items_collected"):
		all_items_collected = true
	
	if state == "normal":
		$AnimatedSprite.animation = "normal"
	if state == "focus":
		$AnimatedSprite.animation = "focus"


#If the player body is detected in this area, item is in focus
func _on_DetectableArea_body_entered(body):
	#checking body is player
	if body.name == "Player":
		if all_items_collected == true:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Menu/GameWon.tscn")
		elif all_items_collected == false:
			state = "focus"
			$NotFinished.visible = true


#If the player body is detected leaving the area, item out of focus
func _on_DetectableArea_body_exited(body):
	#checking body is player
	if body.name == "Player":
		state = "normal"
		$NotFinished.visible = false
