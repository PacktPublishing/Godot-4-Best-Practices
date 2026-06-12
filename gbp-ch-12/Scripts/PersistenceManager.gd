extends Node  
# PersistenceManager.gd  
   
# Signal used to warn Contexts that a scene transition is imminent.  
signal pre_save_path_changed  
   
const BASE_SAVE_DIR: String = "user://game_saves/"  
const MASTER_FILE_NAME: String = "void_defenders_save.json"  
   
func _ready() -> void:  
	# DirAccess allows us to interact with the OS file system safely.  
	if not DirAccess.dir_exists_absolute(BASE_SAVE_DIR):  
		# ensures parent folders are also created if missing  
		DirAccess.make_dir_recursive_absolute(BASE_SAVE_DIR)  
 
# The Context hands its data here to be saved to the hard drive 
func write_save_data(save_dict: Dictionary) -> void: 
	var file_path: String = BASE_SAVE_DIR + MASTER_FILE_NAME 
	var file = FileAccess.open(file_path, FileAccess.WRITE) 
	if file: 
		file.store_string(JSON.stringify(save_dict)) 
		file.close() 
