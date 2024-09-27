extends KinematicBody2D
export(Resource) var resource

#Variables
onready var line: = $Line2D
onready var sprite: = $Sprite
onready var healthBar: = $HealthBar/ProgressBar

var max_health: int
var health: int
var player = null
var player_chase = false
var velocity = Vector2.ZERO
var enemy_spawn_location = Vector2.ZERO
var path: Array = []    #contains the position destinations
var level_navigation: Navigation2D = null
var player_detected = false
var speed: int

#Movement
#When node loads into scene tree...
func _ready():
	#setting up enemy based on resource
	sprite.texture = resource.texture
	max_health = resource.max_health
	health = resource.health
	speed = resource.speed
	Signals.emit_signal("set_enemy_speed")
	
	healthBar.max_value = max_health
	healthBar.value = health
	
	var tree = get_tree()
	#checking for navigation & player nodes, if tree has them, loads nodes
	if tree.has_group("LevelNavigation"):
		level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]
	
	enemy_spawn_location = self.global_position
# warning-ignore:return_value_discarded
	Signals.connect("player_hit", self, "on_player_hit")
# warning-ignore:return_value_discarded
	Signals.connect("enemy_speed_change", self, "on_enemy_speed_change")


func _physics_process(_delta: float) -> void:
	#if enemy is hit by player, health depletes appropriately
	if player_detected == true:
		if Input.is_action_just_pressed("attack"):
			health -= 1
			healthBar.value = health
			if health <= 0:
				Signals.emit_signal("enemy_hit")
				self.queue_free()
	
	#generate line and path to navigate
	line.global_position = Vector2.ZERO
	if player:
		generate_path()
		navigate()
	
	#if player is within attacking distance, move enemy
	if player_chase == true:
		velocity = move_and_slide(velocity)
	#if player is not.. enemy stops chasing
	else:
		velocity = Vector2.ZERO


#Generates path for enemy
func generate_path():
	#if level and player is in tree, generate path to player
	if level_navigation != null and player != null:
		path = level_navigation.get_simple_path(global_position, player.global_position, false)
		line.points = path


#Defines the next position enemy to go to
func navigate():
	#if the path between enemy and player is bigger than 0, moves enemy
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * speed
		#if enemy reaches position, removes point from path array
		if global_position == path[0]:
			path.pop_front()


func on_player_hit():
	self.global_position = enemy_spawn_location


#Sets enemys speed depending on EnemyResource
func on_enemy_speed_change(new_speed):
	speed = new_speed


#If player enters enemy detection zone, sets enemy to chase
func _on_DetectionArea_body_entered(body):
	if body.name == "Player":
		player = body
		player_chase = true


#If player leaves detections zone, sets enemy to not chase anymore
func _on_DetectionArea_body_exited(body):
	if body.name == "Player":
		player = null
		player_chase = false


func _on_Area2D_body_entered(body):
	#if player is detected, shows that player can hit enemy by showing enemys health bar
	if body.name == "Player":
		$HealthBar.visible = true
		player_detected = true


func _on_Area2D_body_exited(body):
	#if player leaves, shows that player can't hit enemy anymore by hiding enemys health bar
	if body.name == "Player":
		$HealthBar.visible = false
		player_detected = false
