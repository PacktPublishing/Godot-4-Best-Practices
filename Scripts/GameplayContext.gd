class_name GameplayContext extends Node 

@onready var hud_manager: HUDManager = $HUDManager  

var level_controller: LevelController 
var level_state: LevelState 
 

func _ready() -> void:
	# 1. Initialize the Pure Data State (Load from Persistence)
	var saved_data: Dictionary = PersistenceManager.read_save_data()
	level_state = LevelState.new() 

	if not saved_data.is_empty():
		print("Loading saved game state...")
		level_state.current_score = saved_data.get("score", 0)
		level_state.current_wave = saved_data.get("wave", 1)
		level_state.player_health = saved_data.get("health", 100)
	else:
		print("Starting a new game...") 

	# 2. Inject state into the Domain Logic
	level_controller = LevelController.new(level_state)
	add_child(level_controller) 

	# 3. Connect the Logic to the Presentation (Call down, signal up)
	level_controller.score_changed.connect(hud_manager.update_score_display)
	level_controller.game_over.connect(hud_manager.show_game_over)
