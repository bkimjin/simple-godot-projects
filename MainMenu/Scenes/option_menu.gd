extends Control
## Heavily influenced by https://www.gotut.net/custom-key-bindings-in-godot-4/
## This script assigns keyboard keys and mouse buttons as key bindings.

@onready var button_ui_up : Button = $MC/MenuVBC/MenuScrollContainer/KeyVBC/UpHBC/ui_up
@onready var button_ui_left : Button = $MC/MenuVBC/MenuScrollContainer/KeyVBC/LeftHBC/ui_left
@onready var button_ui_down : Button = $MC/MenuVBC/MenuScrollContainer/KeyVBC/DownHBC/ui_down
@onready var button_ui_right : Button = $MC/MenuVBC/MenuScrollContainer/KeyVBC/RightHBC/ui_right
@onready var label_up : Label = $MC/MenuVBC/MenuScrollContainer/KeyVBC/UpHBC/Label_Up
@onready var label_left : Label = $MC/MenuVBC/MenuScrollContainer/KeyVBC/LeftHBC/Label_Left
@onready var label_down : Label = $MC/MenuVBC/MenuScrollContainer/KeyVBC/DownHBC/Label_Down
@onready var label_right : Label = $MC/MenuVBC/MenuScrollContainer/KeyVBC/RightHBC/Label_Right
@onready var info_label : Label = $MC/MenuVBC/PanelContainer/KeyChangeLabel
@onready var info_panel : PanelContainer = $MC/MenuVBC/PanelContainer
@onready var texture_button_back: TextureButton = $MC/MenuVBC/Back

@onready var dict_key_label: Dictionary = {"ui_up":label_up, "ui_left":label_left, "ui_down":label_down, "ui_right":label_right}
var current_button : Button

func _ready() -> void:
	# Connect the buttons pressed signal:
	button_ui_up.pressed.connect(_on_button_pressed.bind(button_ui_up))
	button_ui_left.pressed.connect(_on_button_pressed.bind(button_ui_left))
	button_ui_down.pressed.connect(_on_button_pressed.bind(button_ui_down))
	button_ui_right.pressed.connect(_on_button_pressed.bind(button_ui_right))
	texture_button_back.pressed.connect(exit_option)
	
	update_labels()
	
	# Hide the panel.
	info_label.hide()
	info_panel.modulate = Color(info_panel.modulate, 0)
	

## Exit the option menu.
func exit_option() -> void:
	$".".queue_free()

## Whenever a button is pressed, assign it as the current_button and show the "Press any ..." label:
func _on_button_pressed(button: Button) -> void:
	current_button = button # Assign clicked button to current_button.
	info_label.show() # Show the panel with the info.
	info_panel.modulate = Color(info_panel.modulate, 1) # Make the panel opaque.

func _input(event: InputEvent) -> void:
	if !current_button: # return if current_button is null
		return
		
	# Only trigger if input is a key or a mouse button.
	if (event is InputEventKey || event is InputEventMouseButton):
	
		# Only assign input if input is not escape.
		if event.as_text_keycode() != 'Escape':
			# Delete duplicate keys:
			# Add all assigned keys to a dictionary
			var all_ies : Dictionary = {}
			for ia in InputMap.get_actions():
				for iae in InputMap.action_get_events(ia):
					all_ies[iae.as_text()] = ia
			
			# check if the new key is already in the dict.
			# If yes, delete the old one.
			if all_ies.keys().has(event.as_text()):
				InputMap.action_erase_events(all_ies[event.as_text()])
			
			# This part is where the actual remapping occurs:
			# Erase the event in the Input map
			InputMap.action_erase_events(current_button.name)
			# Assign the new event
			InputMap.action_add_event(current_button.name, event)
			
			update_labels()
		
		# After a key is assigned, set current_button back to null.
		current_button = null
		info_panel.modulate = Color(info_panel.modulate, 0)
		info_label.hide()


## Updates the labels based on variable labels and dictionary.
func update_labels() -> void:
	
	for key_binding in dict_key_label:
		# Get the events associated with the action (Ex. ui_right, ui_up).
		var input: Array[InputEvent] = InputMap.action_get_events(key_binding)
		if !input.is_empty():
			# Associate the first input as the label
			dict_key_label[key_binding].text = input[0].as_text()
		else:
			# Clears the label if there is no event for the specified action.
			dict_key_label[key_binding].text = ""
			
	#button_ui_up.
