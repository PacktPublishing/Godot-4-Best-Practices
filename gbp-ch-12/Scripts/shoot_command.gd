# ShootCommand.gd
class_name ShootCommand extends Command  

func execute(actor: Node) -> void:  
	if actor.has_method("fire_weapon"): 
		actor.fire_weapon()
