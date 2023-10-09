extends Area2D


var velocity:=Vector2(0,speed)

@export var speed:float=500
var plBulletEffect:=preload("res://Bullet/enemy_bullet_effect.tscn")


func _ready():
	var rotation_rad = deg_to_rad(rotation_degrees)
	velocity.x = cos(rotation_rad)
	velocity.y = sin(rotation_rad)
	velocity *= speed
func _physics_process(delta):

	position += velocity * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
## At the end of the frame, it disposes the node
	queue_free()


func _on_area_entered(area):
	if randf()<PlayerStats.dodgeChance:
		return
	if area is Player:
		var bulletEffect:=plBulletEffect.instantiate()
		bulletEffect.position=position
		get_parent().add_child(bulletEffect)

		area.damage(1)
		queue_free()
