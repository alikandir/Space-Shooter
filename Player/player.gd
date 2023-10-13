extends Area2D
class_name Player

@onready var animatedSprite:=$AnimatedSprite2D
@onready var engineSprite:=$EnginesSprite
@onready var firingPositions:=$FiringPositions
@onready var fireDelayTimer:=$FireDelayTimer
@onready var rapidFireTimer=$RapidFireTimer
@onready var invincibilityTimer:=$InvincibilityTimer
@onready var shield:=$InvincibilityShield
@onready var deathSound=$DeathSFX
@onready var hitSound=$HitSFX
@onready var moveAnim=$AnimatedSprite2D/MoveAnimation
@onready var plEnemyExplosion:=preload("res://Enemy/enemy_explosion.tscn")



var target_position = Vector2()  # Store the touch position

var vel:= Vector2(0,0)
var rapidFiring=false
var additionalBulletLocations=[Vector2(-20,-17), Vector2(19,-17), Vector2(-35,-10), Vector2(+35,-10)]
var direction:=Vector2(0,0)
### pl stands for preload
# loads before when the player is loading
var plBullet:=preload("res://Bullet/bullet.tscn")

var isTouching:bool=false

func _ready():
	shield.visible=false
	Signals.emit_signal("on_player_life_changed",PlayerStats.playerHealth)
	Signals.connect("on_bullets_upgraded", Callable(self,"_on_bullets_upgraded"))
func _process(delta):

	shoot()
	animationControl()
	screenLimiter()
	## calculate and send position: 
	var playerPosition:=Vector2(position.x,position.y)
	Signals.emit_signal("player_position", playerPosition)


func _physics_process(delta):
	move(delta)
	

func _input(event):
	if event is InputEventScreenTouch:

		if event.pressed:
			# Set the target_position when touch is pressed
			isTouching=true

		elif event.is_released():
			# Reset the target_position when the touch is released or canceled
			isTouching=false
			target_position = Vector2()
			



func move(delta):
	var dirVec:=Vector2(0,0)

	if isTouching:
		target_position=get_global_mouse_position()
		# Check if there's a target position
		if target_position != Vector2():
			# Calculate the direction to move
			direction = (target_position - position).normalized()
			
			# Move the player in the direction
			position += direction * PlayerStats.moveSpeed * delta
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

func shoot():
	if fireDelayTimer.is_stopped():
		fireDelayTimer.start(PlayerStats.fireDelay)
		
		for child in firingPositions.get_children():
			var bullet:=plBullet.instantiate()
			bullet.global_position=child.global_position
			get_tree().current_scene.add_child(bullet)
			$ShootSFX.pitch_scale=randf_range(0.6,1.4)
			$ShootSFX.playing=true




func animationControl():
	animatedSprite.play("Straight")
	engineSprite.play("default")
	
	if (direction.x>0) and isTouching:
		moveAnim.play("move_right")
	elif (direction.x<0) and isTouching:
		moveAnim.play("move_left")
	elif !isTouching:
		moveAnim.play("RESET")
		
	if vel.x>0:
		moveAnim.play("move_right")
	elif vel.x<0:
		moveAnim.play("move_left")
	elif !isTouching:
		moveAnim.play("RESET")
	
	if invincibilityTimer.time_left>1.5:
		$InvincibilityShield/InvincibilityShieldEnding.play("invincibility_flash_normal")
	elif invincibilityTimer.time_left<1.5:
		$InvincibilityShield/InvincibilityShieldEnding.play("invincibility_flash")

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
	$HitAnimation.play("hit_animation")
	hitSound.playing=true
	
	var cam:=get_tree().current_scene.get_node("Camera")
	cam.shake(4)
	
	if PlayerStats.playerHealth<=0:
		var plGameOver=preload("res://MainScenes/game_over.tscn")
		PlayerStats.SaveGame()
		PlayerStats.isAlive=false
		deathSound.playing=true
		visible=false
		var explosionEffect=plEnemyExplosion.instantiate()
		explosionEffect.global_position=global_position
		get_tree().current_scene.add_child(explosionEffect)
		await get_tree().create_timer(1).timeout
		var gameOver = plGameOver.instantiate()
		gameOver.position=position
		get_parent().add_child(gameOver)
		queue_free()
		

func applyExtraLife():
	PlayerStats.playerHealth+=1
	Signals.emit_signal("on_player_life_changed",PlayerStats.playerHealth)
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
			var gunExtra2 =  Node2D.new()
			gunExtra2.position=additionalBulletLocations[1]
			$FiringPositions.add_child(gunExtra2)
			PlayerStats.playerDamage*=0.7
		2:
			#remove the option from the upgrades:
			var capacity_reached=true
			Signals.emit_signal("bullet_capacity_reached", capacity_reached)
			var gunExtra3 =  Node2D.new()
			gunExtra3.position=additionalBulletLocations[2]
			$FiringPositions.add_child(gunExtra3)
			var gunExtra4 =  Node2D.new()
			gunExtra4.position=additionalBulletLocations[3]
			$FiringPositions.add_child(gunExtra4)
			PlayerStats.playerDamage*=0.7

