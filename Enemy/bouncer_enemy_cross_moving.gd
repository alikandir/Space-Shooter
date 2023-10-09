extends BouncerEnemy



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y+=verticalSpeed*delta*1.5
	if fireTimer.is_stopped():
		Shoot()
		fireTimer.start(fireRate)
	CollisionDamage()
