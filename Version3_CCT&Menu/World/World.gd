extends Node2D

#Constants
const MaxHealth = 5
const TotalItems = 7

#Variables
onready var camera: = $Camera2D
onready var player: = $Player
onready var enemy: = $Enemy
onready var playerMenu: = $Camera2D/PlayerScreenMenu
onready var playerHealth: = $Camera2D/PlayerScreenMenu/Health
onready var enemyCollected: = $Camera2D/PlayerScreenMenu/EnemyCount
onready var itemsCollected: = $Camera2D/PlayerScreenMenu/ItemsInventory/Collected
onready var totalItems: = $Camera2D/PlayerScreenMenu/ItemsInventory/Aim
onready var worldItems: = $Items

var items = 0
var health = MaxHealth
var enemy_count = 0
var player_spawn = Vector2.ZERO
var enemy_spawn = Vector2.ZERO

#When node has entered scene tree
func _ready():
	#sets ready labels and positions
	totalItems.text = "/ %s" % TotalItems
	#connect camera to player node
	player.connect_camera(camera)
	player_spawn = player.global_position
	enemy_spawn = enemy.global_position
	set_health_label()
	set_enemy_label()
	set_item_label()
# warning-ignore:return_value_discarded
	Signals.connect("unpaused", self, "on_unpaused")
# warning-ignore:return_value_discarded
	Signals.connect("item_collected", self, "on_item_collected")
# warning-ignore:return_value_discarded
	Signals.connect("esc_pause", self, "on_esc_pause")
# warning-ignore:return_value_discarded
	Signals.connect("player_hit", self, "on_player_hit")
# warning-ignore:return_value_discarded
	Signals.connect("enemy_hit", self, "on_enemy_hit")


#When game is unpaused..
func on_unpaused():
	playerMenu.visible = true
	worldItems.visible = true


#Changes item count when collected
func on_item_collected():
	items += 1
	set_item_label()


#If game is paused by the <esc> method..
func on_esc_pause():
	playerMenu.visible = false
	worldItems.visible = false


#Changes health appropriately so user can see health
func on_player_hit():
	health -= 1
	set_health_label()
	if health > 0:
		pass
	elif health <= 0:
		Signals.emit_signal("player_die")
	#
	if health == 2:
		Signals.emit_signal("player_health", health)


#Changes enemy count when collected
func on_enemy_hit():
	enemy_count += 1
	set_enemy_label()


#If game paused by the pause button..
func _on_PauseButton_focus_entered():
	#pauses scene
	playerMenu.visible = false
	worldItems.visible = false
	Signals.emit_signal("paused_scene")


func set_health_label():
	playerHealth.text = "%s lives left" % health


func set_enemy_label():
	enemyCollected.text = "Enemy Count: %s" % enemy_count


func set_item_label():
	itemsCollected.text = "%s" % items
