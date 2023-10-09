extends Area2D
class_name Player

@onready var animatedSprite:=$AnimatedSprite2D
@onready var engineSprite:=$EnginesSprite
@onready var firingPositions:=$FiringPositions
@onready var fireDelayTimer:=$FireDelayTimer
@onready var rapidFireTimer=$RapidFireTimer
@onready var invincibilityTimer:=$InvincibilityTimer
@onready var shield:=$InvincibilityShield

var vel:= Vector2(0,0)
var rapidFiring=false
var additionalBulletLocations=[Vector2(-2,-27), Vector2(-20,-17), Vector2(19,-17)]

### pl stands for preload
# loads before when the player is loading
var plBullet:=preload("res://Bullet/bullet.tscn")

func _ready():
	shield.visible=false
	Signals.emit_signal("on_player_life_changed",PlayerStats.playerHealth)
	Signals.connect("on_bullets_upgraded", Callable(self,"_on_bullets_upgraded"))
func _process(delta):
	shoot(delta)
	animationControl()
	screenLimiter()
	## calculate and send position: 
	var playerPosition:=Vector2(position.x,position.y)
	Signals.emit_signal("player_position", playerPosition)


func _physics_process(delta):
	move(delta)
	



func move(delta):
	var dirVec:=Vector2(0,0)
	if Input.is_action_pressed("move_left"):
		dirVec.x=-1
	if Input.is_action_pressed("move_right"):
		dirVec.x=+1
	if Input.is_action_pressed("move_down"):
		dirVec.y=1
	if Input.is_action_pressed("move_up"):
		dirVec.y=-1
	vel=dirVec.normalized()*PlayerStats.moveSpeed
	position+=delta*vel

func shoot(delta):	
	if fireDelayTimer.is_stopped():
		fireDelayTimer.start(PlayerStats.fireDelay)
		
		for child in firingPositions.get_children():
			var bullet:=plBullet.instantiate()
			bullet.global_position=child.global_position
			get_tree().current_scene.add_child(bullet)




func animationControl():
	animatedSprite.play("Straight")
	engineSprite.play("default")
	

func screenLimiter():
	## Keep the Player within the screen:
	var viewRect:=get_viewport_rect()
	position.x=clamp(position.x,35,viewRect.size.x-35)
	position.y=clamp(position.y,35,viewRect.size.y-35)
	

func damage(amount:int):
	if !invincibilityTimer.is_stopped():
		return
	
	applyShield(PlayerStats.invincibilityTime)
	
	PlayerStats.playerHealth-=amount
	Signals.emit_signal("on_player_life_changed",PlayerStats.playerHealth)
	
	var cam:=get_tree().current_scene.get_node("Camera")
	cam.shake(4)
	
	if PlayerStats.playerHealth<=0:
		var plGameOver=preload("res://MainScenes/game_over.tscn")
		var gameOver = plGameOver.instantiate()
		gameOver.position=position
		get_parent().add_child(gameOver)
		queue_free()
		

func applyShield(time:float):
	invincibilityTimer.start(time+invincibilityTimer.time_left)
	shield.visible=true
	
func applyRapidFire(time:float):
	if !rapidFiring:
		PlayerStats.normalFireDelay=PlayerStats.fireDelay
	PlayerStats.fireDelay=PlayerStats.rapidFireDelay
	rapidFireTimer.start(time+rapidFireTimer.time_left)
	rapidFiring=true
	
	
func _on_invincibility_timer_timeout():
	shield.visible=false


func _on_rapid_fire_timer_timeout():
	PlayerStats.fireDelay=PlayerStats.normalFireDelay
	rapidFiring=false
func _on_bullets_upgraded(times):
	match times:
		1:
			var gunExtra1 =  Node2D.new()
			gunExtra1.position=additionalBulletLocations[0]
			$FiringPositions.add_child(gunExtra1)
		2:
			var gunExtra2 =  Node2D.new()
			gunExtra2.position=additionalBulletLocations[1]
			$FiringPositions.add_child(gunExtra2)
		3:
			#remove the option from the upgrades:
			var capacity_reached=true
			Signals.emit_signal("bullet_capacity_reached", capacity_reached)
			var gunExtra3 =  Node2D.new()
			gunExtra3.position=additionalBulletLocations[2]
			$FiringPositions.add_child(gunExtra3)
