# 3. gameplay_context.gd (The Glue - Wires them together) 
extends Node 
 
@export var score_manager: Node 
@export var hud: CanvasLayer 
 
func _ready() -> void: 
	# Context safely connects Domain's output to Presentation's input 
	score_manager.score_changed.connect(hud.update_score_display) 
