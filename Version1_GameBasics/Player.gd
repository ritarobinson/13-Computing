extends KinematicBody2D

#CONSTANTS
const MaxSpeed = 90
const Acceleration = 575
const Friction = 600

#VARIABLES
var velocity = Vector2.ZERO

#MOVEMENT
func _physics_process(delta):
#	sets input to have a vector
	var input = Vector2.ZERO
	
#	setting input variables to have speed/value
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	input = input.normalized()
	
#	allowing input to move/stop player
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * MaxSpeed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
	
#	the actualmethod that moves player according to velocity
	move_and_slide(velocity)
	
