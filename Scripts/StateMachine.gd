class_name StateMachine extends Node 

@export var initial_state: State

var current_state: State 
var states: Dictionary = {} 
 

func _ready() -> void:
	# Loop through all children to map out our available states
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_state_transitioned) 

	if initial_state: 
		initial_state.enter() 
		current_state = initial_state 
  

# Delegate the engine's built-in processing to the active state
func _process(delta: float) -> void:
	if current_state: current_state.update(delta) 

 

func _physics_process(delta: float) -> void:
	if current_state: current_state.physics_update(delta)
 

# Handle the transition logic
func on_state_transitioned(state: State, new_state_name: String) -> void:
	# Security check: ignore delayed signals from old states
	if state != current_state:
		return 

	var new_state = states.get(new_state_name.to_lower()) 
	if not new_state: 
		push_warning("State does not exist: ", new_state_name) 
		return 
	 
	# Execute the transition 
	if current_state: 
		current_state.exit() 
	 
	new_state.enter() 
	current_state = new_state
