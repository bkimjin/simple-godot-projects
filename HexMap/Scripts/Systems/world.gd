extends Node3D

## Dictionary to store Vector2i(q, r) → tile instance
var placed_tiles: Dictionary = {}
## Dictionary to store Vector2i(q, r) → placeholder tile instance
var placed_placeholder_tiles: Dictionary = {}
@onready var tile_scene = preload("res://Scenes3d/HexTile.tscn")
@onready var tile_placeholder = preload("res://Scenes3d/HexPlaceholder.tscn")
@onready var spawner = $HexSpawner


func _ready():
	spawn_tile(0, 0)  # Place the first tile in the center


## Spawns a hex tile at the given axial coordinates (q, r) and triggers spawning of placeholder
## tiles around it.
func spawn_tile(q: int, r: int):
	var tile = spawner.spawn_tile(q, r)
	tile.axial_coords = Vector2i(q, r)
	add_child(tile)
	placed_tiles[Vector2i(q, r)] = tile

	spawn_surrounding_placeholders(q, r)


## Spawns placeholder tiles around a tile at (q, r). Only spawns in adjacent positions that are not
## already occupied by a tile or another placeholder. Uses axial offsets to determine valid
## neighbor positions.
func spawn_surrounding_placeholders(q: int, r: int):
	for offset in HexUtils.get_ring_offsets():
		var new_q = q + offset.x
		var new_r = r + offset.y
		var coord = Vector2i(new_q, new_r)

		if placed_tiles.has(coord) or placed_placeholder_tiles.has(coord):
			continue  # Already exists, skip.

		var placeholder = spawner.spawn_placeholder(new_q, new_r)
		placeholder.connect("placeholder_clicked", Callable(self, "_on_placeholder_clicked"))
		add_child(placeholder)

		# Track location of placeholder tiles.
		placed_placeholder_tiles[coord] = placeholder


## When a placeholder is clicked, removes the placeholder, spawns a tile on the location, and
## spawns placeholders surrounding the tile if possible.
func _on_placeholder_clicked(q: int, r: int):
	# Remove the clicked placeholder from world.
	var coord = Vector2i(q, r)
	print("Removing placeholder at axial position: ", coord, "	|		global position: ", HexUtils.hex_to_world(q, r))
	var placeholder = placed_placeholder_tiles.get(coord)
	if placeholder:
		placeholder.queue_free()
		placed_placeholder_tiles.erase(coord)

	# Spawn the real tile at the placeholder location.
	spawn_tile(q, r)

	# Add placeholders around the newly spawned tile.
	spawn_surrounding_placeholders(q, r)
