extends KinematicBody2D
export(Resource) var resource
class_name Player

#Constants
const Acceleration = 575
const Friction = 600

#Variables
onready var remoteTransform2D: = $RemoteTransform2D

var velocity = Vector2.ZERO
var speed: int	#speed is not a constant as speed will change if at a lower health or if sensitivity is changed
var player_spawn_location = Vector2.ZERO
var left: String
var right: String
var up: String
var down: String

func _ready():
	speed = resource.speed
	Signals.emit_signal("set_speed")
	
	player_spawn_location = self.global_position
	#for controls to be changed/kept
	if Signals.has_user_signal("arrows_control"):
		#connecting for controls
# warning-ignore:return_value_discarded
		Signals.connect("arrows_control", self, "on_arrows_control")
		on_arrows_control()
	else:
	#initialising input map controls
		left = "W_left"
		right = "W_right"
		up = "W_up"
		down = "W_down"
	
	#for the user change in avatar to green
	if Signals.has_user_signal("green_avatar"):
		#connecting for blue avatar
# warning-ignore:return_value_discarded
		Signals.connect("green_avatar", self, "on_green_avatar")
		on_green_avatar()

	#for the user change in avatar to blue
	if Signals.has_user_signal("blue_avatar"):
		#connecting for blue avatar 
# warning-ignore:return_value_discarded
		Signals.connect("blue_avatar", self, "on_blue_avatar")
		on_blue_avatar()
	
# warning-ignore:return_value_discarded
	Signals.connect("player_die", self, "on_player_die")
# warning-ignore:return_value_discarded
	Signals.connect("speed_change", self, "on_speed_change")


#Changes controls to arrows instead of the default WASD
func on_arrows_control():
	#initialising input map controls
	left = "A_left"
	right = "A_right"
	up = "A_up"
	down = "A_down"


#Sets player character to green
func on_green_avatar():
	$Icon.set_modulate(Color(0.06, 0.85, 0.05, 1.00))


#Sets player character to blue
func on_blue_avatar():
	$Icon.set_modulate(Color(1.00, 1.00, 1.00, 1.00))


#Sets player speed to slower speed if health = 2(this code is in PlayerSpeed script)
func on_speed_change(player_speed):
	speed = player_speed


#Movement
func _physics_process(delta):
	#sets input to have a vector
	var input = Vector2.ZERO

	#setting input variables to have speed/value
	input.x = Input.get_axis(left, right)
	input.y = Input.get_axis(up, down)
	input = input.normalized()

	#allowing input to move/stop player
	if input != Vector2.ZERO:
		velocity = velocity.move_toward(input * speed, Acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
	#the actual method that moves player according to velocity
	velocity = move_and_slide(velocity)

	#if player collides with node, get nodes name
	for index in get_slide_count():
		var collision := get_slide_collision(index)
		var body = collision.collider
		#if player collides with enemy, kill player
		var body_name = body.name
		var body_collider = body_name.split("_", true, 1)
		var enemy_collider = body_collider[0]
		if len(enemy_collider) == 5 and enemy_collider == "Enemy":
			#gets player back to spawn location
			self.global_position = player_spawn_location
			Signals.emit_signal("player_hit")
			break


#If player dies
func on_player_die():
	#kills player
	queue_free()
	#goes to game over menu once died
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu/GameOver.tscn")


#Connects camera to player
func connect_camera(camera):
	var camera_path = camera.get_path()
	remoteTransform2D.remote_path = camera_path
