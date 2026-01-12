class_name CombatCalculator
# This implicitly extends RefCounted

static func calculate_damage(attacker: Node, defender: Node) -> int:
	var base_damage = attacker.stats.strength * 2
	var mitigation = defender.stats.armor / 2
	
	# Pure logic, no scene tree interaction
	var final_damage = base_damage - mitigation
	return max(0, final_damage)
	
