# ShieldCommand.gd
class_name ShieldCommand extends Command  

func execute(actor: Node) -> void:  
	if actor.has_method("activate_shield"): 
		actor.activate_shield()
