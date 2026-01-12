# Inventory.gd (The Anti-Pattern)
extends Node2D

func add_item(item_scene: PackedScene):
	var new_item = item_scene.instantiate()
	add_child(new_item)
	print("Added " + new_item.item_name)

func get_items():
	return get_children()
