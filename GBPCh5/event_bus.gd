# ==========================================
# EVENT BUS (Autoload / Singleton)
# ==========================================
# This script acts as the central communication switchboard for Void Defenders.
# By registering this script as an Autoload in the Project Settings, it becomes 
# globally accessible. 
# 
# Instead of the Player needing a direct path to the HUD to update health, 
# the Player simply shouts to this EventBus. The HUD listens to the EventBus. 
# Neither node knows the other exists. This is the purest form of Loose Coupling.

extends Node

# Godot's built-in error checker will flag a warning if a signal is defined 
# but never emitted from within the *same* script. 
# Because this is an Event Bus, these signals are exclusively emitted by OTHER 
# scripts (like PlayerShip.gd or Enemy.gd). 
# We use @warning_ignore to suppress this false positive and keep our console clean.
@warning_ignore("unused_signal")

# Emitted when an enemy is destroyed, an asteroid is mined, or scrap is collected.
# Listeners: The HUD (to update the visual numbers) and potentially a GameManager.
signal score_changed(new_amount: int)


@warning_ignore("unused_signal")
# Emitted specifically when the Player's hull integrity fails and a life is lost.
# Listeners: The HUD (to remove a life icon) and the GameState (to trigger Game Over).
signal player_lives_changed(current_lives: int)


@warning_ignore("unused_signal")
# Emitted by the Blaster component whenever a weapon powerup is picked up, 
# or when a limited-ammo weapon (like the Plasma Blaster) fires a shot.
# Listeners: The HUD (to display the name and remaining ammunition).
signal weapon_changed(weapon_name: String, ammo: int)
