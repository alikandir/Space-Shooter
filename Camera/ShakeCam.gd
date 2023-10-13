extends Camera2D
@export var shakeBaseAmount=1.0
@export var shakeDampening=0.075
var shakeAmount=0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if shakeAmount>0:
		pass
	else:
		position=Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shakeAmount>0:
		position.x=randf_range(-shakeBaseAmount,shakeBaseAmount)*shakeAmount
		position.y= randf_range(-shakeAmount,shakeBaseAmount)*shakeAmount
		shakeAmount=lerp(shakeAmount,0.0,shakeDampening)
	
	
func shake(magnitude:float):
	if shakeAmount<2.5:
		shakeAmount+=magnitude
	else:
		shakeAmount=2.5
