extends Enemy

var plRocket=preload("res://Enemy/Rocket.tscn")
var inPlace:bool=false
var fireDelay:float=3

func _ready():
	plBullet=preload("res://Enemy/Rocket.tscn")
	$AnimatedSprite2D.play("default")


func _physics_process(delta):
	if !inPlace:
		position.y+=delta*verticalSpeed*10
		if position.y>100:
			inPlace=true
			canShoot=true
	print_debug($FireTimer.time_left)
	CollisionDamage()
	if $FireTimer.is_stopped():
		Shoot()
		$FireTimer.start(fireDelay)
		
	


func _on_fire_timer_timeout():
	pass # Replace with function body.
