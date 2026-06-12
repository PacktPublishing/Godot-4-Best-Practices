# PlayerInputHandler.gd
class_name PlayerInputHandler extends Node  

func get_command() -> Command:  
	if Input.is_action_pressed("fire_weapon"):   
		return ShootCommand.new()  
	elif Input.is_action_just_pressed("deploy_shield"):   
		return ShieldCommand.new()  
		  
	return null
