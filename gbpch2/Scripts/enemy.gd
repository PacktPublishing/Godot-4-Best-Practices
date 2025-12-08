extends CharacterBody2D
class_name Enemy

# Export options demonstration
@export_group("My Properties")
@export var first_property = 1
@export_subgroup("Additional Properties")
@export var flag = false
@export_category("Primary Category")
@export_range(0,20) var i

#@export var attack_component: AttackComponent
var attack_component
func _ready() -> void:
	attack_component = tnt_attack_component.new()
	perform_attack()
	
	
func perform_attack():
	attack_component.attack()
