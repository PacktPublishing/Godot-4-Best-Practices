class_name SaverLoader extends Node

static func save_game(player_health: int):
	var file = FileAccess.open("user://savegame.data", FileAccess.WRITE)
	file.store_var(player_health)
	file.close()
	

static func load_game() -> int:
	var file = FileAccess.open("user://savegame.data", FileAccess.READ)
	var player_health: int = file.get_var()
	file.close()
	return player_health
	
