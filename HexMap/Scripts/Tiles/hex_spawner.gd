class_name HexSpawner
extends Node
## HexSpawner
## 
## This class handles instantiation of hex tile and placeholder scenes.
## Provides reusable spawn functions that convert axial coordinates to 3D world positions.
##
## Expects scene resources to be assigned via the Inspector or at runtime.

@export var hex_tile: PackedScene
@export var placeholder_tile: PackedScene
@export var tile_radius: float = 1.0
@export var tile_height_offset: float = 0.0  # Optional vertical offset


## Instantiates and returns a HexTile scene at the specified axial coordinates.
## Applies radius and height offset as configured.
func spawn_tile(q: int, r: int) -> Node3D:
	var tile = hex_tile.instantiate()
	tile.position = HexUtils.hex_to_world(q, r, tile_radius) + Vector3(0, tile_height_offset, 0)
	tile.axial_coords = Vector2i(q, r)
	return tile


## Instantiates and returns a HexPlaceholder scene at the specified axial coordinates.
## Uses axial-to-world conversion and does not attach the node to the tree.
func spawn_placeholder(q: int, r: int) -> Area3D:
	var placeholder = placeholder_tile.instantiate()
	placeholder.position = HexUtils.hex_to_world(q, r, tile_radius)
	placeholder.axial_coords = Vector2i(q, r)
	return placeholder
