class_name Powerup
extends Area2D


@export var powerupMoveSpeed:float=50


func _physics_process(delta):
	position.y+=powerupMoveSpeed*delta

func _on_area_entered(area):
	if area is Player:
		applyPowerup(area)
		queue_free()

func applyPowerup(player:Player):
	#this needs to be implemented by the inheriting class.
	pass



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
