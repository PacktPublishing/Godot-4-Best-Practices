class_name LevelController extends Node 
 
signal score_changed(new_score: int) 
signal game_over 
 
var state: LevelState 
 
func _init(initial_state: LevelState) -> void: 
	state = initial_state 
 
func enemy_destroyed(point_value: int) -> void: 
	if state.is_game_over: 
		return 
		 
	state.current_score += point_value 
	score_changed.emit(state.current_score) 
 
func player_took_damage(amount: int) -> void: 
	state.player_health -= amount 
	if state.player_health <= 0: 
		state.is_game_over = true 
		game_over.emit() 
