extends Area3D
## HexPlaceholder
##
## Represents an empty placeholder where a tile can be spawned.
## Emits a signal when clicked, forwarding its axial coordinates to a listener (typically `world.gd`).
##
## Instantiated by `HexSpawner`, and removed when converted to a real tile.

signal placeholder_clicked(q: int, r: int)
var axial_coords: Vector2i


func _ready():
	input_event.connect(_on_input_event)
	

func _on_input_event(_camera, event, _event_position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		emit_signal("placeholder_clicked", axial_coords.x, axial_coords.y)
