extends Enemy
class_name SlowShooter
@onready var fireTimer=$FireTimer
@export var fireRate:float=2
var initialFireTime:float=0.8
func _ready():
	fireTimer.start(initialFireTime)
func _process(delta):
	if fireTimer.is_stopped():
		Shoot()
		fireTimer.start(fireRate)


