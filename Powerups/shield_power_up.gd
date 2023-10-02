extends  Powerup

@export var shieldTime:float=5

func applyPowerup(player:Player):
	player.applyShield(shieldTime)
