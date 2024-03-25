extends KinematicBody2D
class_name Player

#CONSTANTS
const Speed = 80
const Acceleration = 575
const Friction = 600

#VARIABLES
onready var remote_transform2D: = $RemoteTransform2D
onready var player_collision: = $PlayerCollision

var velocity = Vector2.ZERO


#MOVEMENT
func _physics_process(delta):
#sets input to have a vector
	var input = Vector2.ZERO
	
#setting input variables to have speed/value
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")
	input = input.normalized()
	
#allowing input to move/stop player
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * Speed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
#the actual method that moves player according to velocity
	velocity = move_and_slide(velocity)
	
#if player collides with node, get nodes name
	for index in get_slide_count():
		var collision := get_slide_collision(index)
		var body = collision.collider
#if player collides with enemy, kill player
		if body.name == "Enemy":
			player_die()
		else:
			pass


#if player dies
func player_die():
#kills Player
	queue_free()
#	get_tree().change_scene("...")



#connects camera to player
func connect_camera(camera):
	var camera_path = camera.get_path()
	remote_transform2D.remote_path = camera_path
