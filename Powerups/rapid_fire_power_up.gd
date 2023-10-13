extends Powerup
var plSound=preload("res://Powerups/power_up_sound.tscn")
@export var rapidFireTime:float=3
func _ready():
	$AnimatedSprite2D.play("default")
func applyPowerup(player:Player):
	player.applyRapidFire(rapidFireTime)
	var sound=plSound.instantiate()
	sound.position=position
	get_tree().current_scene.add_child(sound)
