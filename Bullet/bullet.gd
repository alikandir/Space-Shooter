extends Area2D


@export var speed:float=500
var plBulletEffect:=preload("res://Bullet/bullet_effect.tscn")


func _physics_process(delta):
	position.y-=speed*delta
	


func _on_visible_on_screen_notifier_2d_screen_exited():
## At the end of the frame, it disposes the node
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("damageable"):
		var bulletEffect:=plBulletEffect.instantiate()
		bulletEffect.position=position
		get_parent().add_child(bulletEffect)
		area.damage(PlayerStats.playerDamage)
		
		var cam:=get_tree().current_scene.get_node("Camera")
		cam.shake(1.2)
		queue_free()
		
