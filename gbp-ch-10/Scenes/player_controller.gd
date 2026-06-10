# PlayerController.gd
class_name PlayerController extends Node 

@export var player_actor: PlayerShip 
@onready var input_handler: PlayerInputHandler = $PlayerInputHandler 

func _physics_process(_delta: float) -> void: 
	if not player_actor:
		return
		
	# 1. Generate the command from the input stream 
	var command: Command = input_handler.get_command() 
	  
	# 2. If a command was generated, execute it on our specific actor 
	if command: 
		command.execute(player_actor)
