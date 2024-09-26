extends Node

#Signals
# warning-ignore:unused_signal
signal paused_scene
# warning-ignore:unused_signal
signal unpaused
# warning-ignore:unused_signal
signal item_collected
# warning-ignore:unused_signal
signal esc_pause
# warning-ignore:unused_signal
signal player_hit
# warning-ignore:unused_signal
signal player_die
# warning-ignore:unused_signal
signal enemy_hit
# warning-ignore:unused_signal
signal set_speed
# warning-ignore:unused_signal
signal set_enemy_speed
# warning-ignore:unused_signal
signal speed_change()
# warning-ignore:unused_signal
signal enemy_speed_change()
# warning-ignore:unused_signal
signal player_health()
# warning-ignore:unused_signal
signal speed_sensitivity
# warning-ignore:unused_signal
signal enemy_speed_sensitivity()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
