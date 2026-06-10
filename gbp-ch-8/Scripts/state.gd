class_name State extends Node 

# Emitted when this state wants to pass control to another state
signal transitioned(state: State, new_state_name: String) 

# Virtual functions to be overridden by specific states
func enter() -> void: pass
 

func exit() -> void: pass
 

func update(_delta: float) -> void: pass
 

func physics_update(_delta: float) -> void: pass 
