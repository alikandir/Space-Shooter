extends Enemy
class_name SlowShooter
@onready var fireTimer=$FireTimer
@export var fireRate:float=2
func _process(delta):
	if fireTimer.is_stopped():
		Shoot()
		fireTimer.start(fireRate)


