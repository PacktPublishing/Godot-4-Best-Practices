# ==========================================  
# PLAYER STATS (Stateful Resource)  
# ==========================================  
class_name PlayerStats extends Resource 
 
# --- STATE VARIABLES & AUTOMATIC SIGNALS ---  
# By using Godot 4 setter functions, any time a script changes these variables,  
# the Resource updates its internal state AND tells the global EventBus to broadcast it. 
 
@export var current_score: int = 0:  
	set(value):  
		current_score = value  
		EventBus.score_changed.emit(current_score)  
 
@export var current_lives: int = 3:  
	set(value):  
		current_lives = value  
		EventBus.player_lives_changed.emit(current_lives)
