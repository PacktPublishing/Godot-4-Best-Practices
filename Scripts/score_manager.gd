# The Good Approach: Strict Separation 
# 1. score_manager.gd (Domain Layer - No visuals)  
extends Node  
 
var current_score: int = 0   
signal score_changed(new_score: int)  
 
func add_points(base_points: int, combo_multiplier: float) -> void:   
	# The dedicated controller handles the math and remembers the state  
	current_score += (base_points * combo_multiplier)  
	score_changed.emit(current_score) 
