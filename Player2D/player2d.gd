extends CharacterBody2D
## This script controls the movement of the player.

@export_category("Attributes")
## This controls how fast Player2D moves.
@export var speed: int = 500


func _ready():
	setup_input_keys()

## This function assigns the keys W, A, S, and D into the InputMap. This is to
## ensure that this script can function without requiring any modifications.
func setup_input_keys() -> void:
	# Initialize new inputs
	var up: InputEventKey = InputEventKey.new()
	var left: InputEventKey = InputEventKey.new()
	var down: InputEventKey = InputEventKey.new()
	var right: InputEventKey = InputEventKey.new()
	
	# Assign inputs (W, A, S, D) for player movement
	up.physical_keycode = KEY_W
	left.physical_keycode = KEY_A
	down.physical_keycode = KEY_S
	right.physical_keycode = KEY_D
	
	# Associate actions to the inputs. Following actions are defaults under:
	# Project -> Project Settings -> Input Map
	InputMap.action_add_event("ui_up", up)
	InputMap.action_add_event("ui_left", left)
	InputMap.action_add_event("ui_down", down)
	InputMap.action_add_event("ui_right", right)


func _process(_delta):
	
	# Translates inputs into the movement of "Player"
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * speed
	move_and_slide()
	
	# Mouse position determines rotation of object
	look_at(get_global_mouse_position())
