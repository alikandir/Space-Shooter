extends SlowShooter
class_name BouncerEnemy

@export var horizontalSpeed=50

var horizontalDirection:int=1
var inPlace:bool=false

func _ready():
	$ShipSprite.play("default")

func _physics_process(delta):
	if !inPlace:
		position.y+=delta*verticalSpeed*10
		if position.y>100:
			inPlace=true
			canShoot=true
			
	CollisionDamage()
	PlayAnimation()
	
	
	if inPlace:
		position.x+=horizontalSpeed*delta*horizontalDirection
		
		var viewRect=get_viewport_rect()
		if position.x<viewRect.position.x+35 or position.x>viewRect.end.x-35:
			horizontalDirection*=-1

func PlayAnimation():
	if $FireTimer.time_left<0.35:
		$FiringPositions/LeftGun.play("shooting")
		$FiringPositions/RightGun.play("shooting")
	else:
		$FiringPositions/LeftGun.play("not shooting")
		$FiringPositions/RightGun.play("not shooting")
		
