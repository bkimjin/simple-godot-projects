extends Node3D
## HexTile
##
## Represents a placed hex tile in the world grid.
## Handles player interaction (e.g. selection, input) and stores axial grid coordinates.
##
## Usually instantiated and added to the scene by `HexSpawner`.

@export var TILE_RADIUS: float = 1.0
@export var WIDTH: float = TILE_RADIUS * 2
@export var HEIGHT: float = sqrt(3) * TILE_RADIUS
var axial_coords: Vector2i
@onready var area = $ClickArea


func _ready():
	area.input_event.connect(_on_area_input_event)


## Does an action if a tile is selected.
func _on_area_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
		print("HexTile clicked at axial position: ", axial_coords, "		|		global position: ", global_position, " ")
