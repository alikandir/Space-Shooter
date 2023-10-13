extends BouncerEnemy
class_name TargetingEnemy
var playerPosition:Vector2
@onready var gun:AnimatedSprite2D=get_node("FiringPositions/Gun")


func _ready():
	health=PlayerStats.enemyHealths["bigEnemyHealth"]
	plBullet=preload("res://Bullet/enemy_bullet_following.tscn")
	Signals.connect("player_position",Callable(self,"get_player_position"))
func _physics_process(delta):
	if !inPlace:
		position.y+=delta*verticalSpeed*10
		if position.y>250:
			inPlace=true
			canShoot=true
			
	CollisionDamage()
	PlayAnimation()
	if inPlace:
		look_at(playerPosition)
		

func get_player_position(PlayerPosition):
	playerPosition = PlayerPosition
	
func PlayAnimation():
	if $FireTimer.time_left<0.25:
		$FiringPositions/Gun.play("shooting")
	else:
		$FiringPositions/Gun.play("not shooting")
		
	

