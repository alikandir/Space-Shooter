extends Area2D
class_name Player

@onready var animatedSprite:=$AnimatedSprite2D
@onready var firingPositions:=$FiringPositions
@onready var fireDelayTimer:=$FireDelayTimer
@onready var rapidFireTimer=$RapidFireTimer
@onready var invincibilityTimer:=$InvincibilityTimer
@onready var shield:=$InvincibilityShield


@export var speed: float=100
@export var normalFireDelay:float=0.2
@export var rapidFireDelay=0.1
var fireDelay= normalFireDelay
@export var playerHealth:int=3
@export var invincibilityTime:float=0.5

var vel:= Vector2(0,0)

### pl stands for preload
# loads before when the player is loading
var plBullet:=preload("res://Bullet/bullet.tscn")

func _ready():
	shield.visible=false
	Signals.emit_signal("on_player_life_changed",playerHealth)
	Signals.connect("on_bullets_upgraded", Callable(self,"_on_bullets_upgraded"))
func _process(delta):
	shoot(delta)
	animationControl()
	screenLimiter()


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
	vel=dirVec.normalized()*speed
	position+=delta*vel

func shoot(delta):	
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(PlayerStats.fireDelay)
		
		for child in firingPositions.get_children():
			var bullet:=plBullet.instantiate()
			bullet.global_position=child.global_position
			get_tree().current_scene.add_child(bullet)




func animationControl():
	if vel.x<0:
		animatedSprite.play("Left")
	elif vel.x>0:
		animatedSprite.play("Right")
	else :
		animatedSprite.play("Straight")

func screenLimiter():
	## Keep the Player within the screen:
	var viewRect:=get_viewport_rect()
	position.x=clamp(position.x,35,viewRect.size.x-35)
	position.y=clamp(position.y,35,viewRect.size.y-35)
	

func damage(amount:int):
	if !invincibilityTimer.is_stopped():
		return
	
	applyShield(invincibilityTime)
	
	playerHealth-=amount
	Signals.emit_signal("on_player_life_changed",playerHealth)
	
	var cam:=get_tree().current_scene.get_node("Camera")
	cam.shake(4)
	
	if playerHealth<=0:
		print("player died")
		queue_free()
		

func applyShield(time:float):
	invincibilityTimer.start(invincibilityTime+invincibilityTimer.time_left)
	shield.visible=true
	
func applyRapidFire(time:float):
	PlayerStats.normalFireDelay=fireDelay
	PlayerStats.fireDelay=PlayerStats.rapidFireDelay
	rapidFireTimer.start(time+rapidFireTimer.time_left)
	
	
func _on_invincibility_timer_timeout():
	shield.visible=false


func _on_rapid_fire_timer_timeout():
	PlayerStats.fireDelay=PlayerStats.normalFireDelay

func _on_bullets_upgraded(times):
	match times:
		1:
			pass
