extends KinematicBody2D

#CONSTANTS
const Speed = 50

#VARIABLES
onready var line = $Line2D

var player = null
var player_chase = false
var velocity := Vector2.ZERO
var path: Array = []    #contains the position destinations
var level_navigation: Navigation2D = null


#MOVEMENT
#when node loads into scene tree...
func _ready():
	var tree = get_tree()
#checking for navigation & player nodes, if tree has them, loads nodes
	if tree.has_group("LevelNavigation"):
		level_navigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player"):
		player = tree.get_nodes_in_group("Player")[0]


func _physics_process(_delta: float) -> void:
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


#generates path for enemy
func generate_path():
#if level and player is in tree, generate path to player
	if level_navigation != null and player != null:
		path = level_navigation.get_simple_path(global_position, player.global_position, false)
		line.points = path


#defines the next position enemy to go to
func navigate():
#if the path between enemy and player is bigger than 0, moves enemy
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * Speed
#if enemy reaches position, removes point from path array
		if global_position == path[0]:
			path.pop_front()


#if player enters enemy detection zone, sets enemy to chase
func _on_DetectionArea_body_entered(body):
	player = body
	player_chase = true


#if player leaves detections zone, sets enemy to not chase anymore
# warning-ignore:unused_argument
func _on_DetectionArea_body_exited(body):
	player = null
	player_chase = false

