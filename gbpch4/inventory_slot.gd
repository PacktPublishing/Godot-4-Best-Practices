# InventorySlot.gd
extends PanelContainer

@onready var icon_texture = $TextureRect

func set_icon(new_icon: Texture2D):
	icon_texture.texture = new_icon
