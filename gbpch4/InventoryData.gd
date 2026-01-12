# InventoryData.gd
class_name InventoryData
extends Resource

@export var items: Array[ItemData] = []

func add_item(new_item: ItemData):
	items.append(new_item)
	emit_changed() # Notify listeners that data changed

func remove_item(index: int):
	items.remove_at(index)
	emit_changed()
