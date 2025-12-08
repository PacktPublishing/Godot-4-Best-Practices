@tool
extends Node2D

@export var radius: float = 100.0:
	set(value):
		radius = value
		queue_redraw() # This is the key line

func _draw() -> void:
	if Engine.is_editor_hint():
		# Draws a red circle with 0.3 (30%) opacity
		draw_circle(Vector2.ZERO, radius, Color(1, 0, 0, 0.3))
