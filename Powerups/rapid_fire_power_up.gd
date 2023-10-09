extends Powerup

@export var rapidFireTime:float=4
func _ready():
	$AnimatedSprite2D.play("default")
func applyPowerup(player:Player):
	player.applyRapidFire(rapidFireTime)
