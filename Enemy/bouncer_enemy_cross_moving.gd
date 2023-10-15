extends BouncerEnemy
class_name CrossBouncer

func _ready():
	health=PlayerStats.enemyHealths["midEnemyHealth"]
	inPlacePosition = 120
	fireTimer.start(initialFireTime)

func _process(delta):
	position.y+=verticalSpeed*delta*1.5
	if fireTimer.is_stopped():
		Shoot()
		fireTimer.start(fireRate)
	CollisionDamage()
