extends Node2D

#Variables
var state = "collectable"
var player_detected = false
var item_collected = false

#Checking states of item, changing appropriatly
func _process(_delta):
	if state == "collected":
		$AnimatedSprite.animation = "collected"
	if state == "collectable":
		$AnimatedSprite.animation = "collectable"
	#if player collects the item..
	if player_detected == true:
		if state != "collected":
			if Input.is_action_just_pressed("collect"):
				state = "collected"
				item_collected = true
				Signals.emit_signal("item_collected")


#If the player body is detected in this area, item is in focus
func _on_DetectableArea_body_entered(body):
	if state != "collected":
		#checking body is player
		if body.name == "Player":
			state = "focus"
			player_detected = true
			#changing appropriately
			if item_collected == false:
				$AnimatedSprite.animation = "focus"
			elif item_collected == true: pass


#If the player body is detected leaving the area, item out of focus
func _on_DetectableArea_body_exited(body):
	if state != "collected":
		#checking body is player
		if body.name == "Player":
			player_detected = false
			#changing appropriately
			if item_collected == false:
				$AnimatedSprite.animation = "collectable"
			elif item_collected == true: pass
