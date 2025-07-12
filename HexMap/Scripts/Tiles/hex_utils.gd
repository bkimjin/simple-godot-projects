class_name HexUtils
extends Node
## HexUtils
##
## Static utility class for working with hex coordinate systems.
## Contains helper functions to convert axial hex coordinates to world positions.
##
## This is a pure, logic-only helper with no scene or node responsibilities.

## Convert hex coordinates to world coordinates.
static func hex_to_world(q: int, r: int, radius: float = 1.0) -> Vector3:
	var width = radius * 2.0
	var height = sqrt(3) * radius
	var x = width * 0.75 * q
	var z = height * (r + q * 0.5)
	return Vector3(x, 0, z)


## Returns the current tile's offsets.
static func get_ring_offsets() -> Array[Vector2i]:
	return [
		Vector2i(1, 0),
		Vector2i(1, -1),
		Vector2i(0, -1),
		Vector2i(-1, 0),
		Vector2i(-1, 1),
		Vector2i(0, 1)
	]
