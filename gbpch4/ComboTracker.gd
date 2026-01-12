class_name ComboTracker extends RefCounted # Explicit extension optional

var combo_count: int = 0
var last_hit_time: float = 0.0

func add_hit(time: float) -> void:
	if time - last_hit_time < 1.0:
		combo_count += 1
	else:
		combo_count = 1
	last_hit_time = time
