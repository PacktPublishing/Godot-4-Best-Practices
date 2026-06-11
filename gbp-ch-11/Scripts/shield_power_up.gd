extends BasePowerup

func apply_powerup(player: PlayerShip) -> void:
	player.activate_shield()
