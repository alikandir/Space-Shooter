extends SlowShooter


@export var horizontalSpeed=50
var horizontalDirection:int=1

func _physics_process(delta):
	position.x+=horizontalSpeed*delta*horizontalDirection
	
	var viewRect=get_viewport_rect()
	if position.x<viewRect.position.x+35 or position.x>viewRect.end.x-35:
		horizontalDirection*=-1
