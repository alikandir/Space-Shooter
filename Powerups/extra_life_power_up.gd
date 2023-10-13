extends Powerup

var plSound=preload("res://Powerups/power_up_sound.tscn")
func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	position.y+=powerupMoveSpeed*delta
func applyPowerup(player:Player):
	player.applyExtraLife()
	var sound=plSound.instantiate()
	sound.position=position
	get_tree().current_scene.add_child(sound)


