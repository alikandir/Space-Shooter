extends  Powerup


func _ready():
	$AnimatedSprite2D.play("default")
func applyPowerup(player:Player):
	player.applyShield(PlayerStats.shieldTime)
