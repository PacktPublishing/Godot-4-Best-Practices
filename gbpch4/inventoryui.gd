# InventoryUI.gd
extends Control

# The Data (Model)
@export var inventory_data: InventoryData

# The Visual Prefab (View)
@export var slot_scene: PackedScene 

func _ready():
	# Only try to connect if data exists to avoid crashes during testing
	if inventory_data:
		inventory_data.changed.connect(update_ui)
		update_ui()

func update_ui():
	# 1. Clear existing UI nodes
	for child in $Grid.get_children():
		child.queue_free()
	
	# 2. Create visual representations for the data
	for item in inventory_data.items:
		# We use the exported PackedScene to create the instance
		var slot = slot_scene.instantiate()
		$Grid.add_child(slot)
		
		# We pass the data to the slot
		if slot.has_method("set_icon"):
			slot.set_icon(item.icon)
			FileAccess
