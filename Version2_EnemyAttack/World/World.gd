extends Node2D

#VARIABLES
onready var camera: = $Camera2D
onready var player: = $Player


#when node has entered scene tree
func _ready():
#	connect camera to player node
	player.connect_camera(camera)
