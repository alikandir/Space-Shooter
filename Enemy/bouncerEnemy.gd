extends SlowShooter
class_name BouncerEnemy

@export var horizontalSpeed=50
var inPlacePosition:float=200
var horizontalDirection:int=1
var inPlace:bool=false
@onready var hit_flash_anim=$HitFlashAnimation
var plHitSound=preload("res://SFX/hit_sound.tscn")
var plDeathSound=preload("res://SFX/death_sound_enemy.tscn")
func _ready():
	$ShipSprite.play("default")
	health=PlayerStats.enemyHealths["midEnemyHealth"]

func _physics_process(delta):
	if !inPlace:
		position.y+=delta*verticalSpeed*10
		if position.y>inPlacePosition:
			inPlace=true
			canShoot=true
			
	CollisionDamage()
	PlayAnimation()
	
	
	if inPlace:
		position.x+=horizontalSpeed*delta*horizontalDirection
		
		var viewRect=get_viewport_rect()
		if position.x<viewRect.position.x+35 or position.x>viewRect.end.x-35:
			horizontalDirection*=-1
func damage(amount:float):
	if health<=0:
		return
	health-=amount
	hit_flash_anim.play("hit_flash")
	var hitSound=plHitSound.instantiate()
	hitSound.position=position
	get_tree().current_scene.add_child(hitSound)

	
	if health<=0:
		var scrap=plScrap.instantiate()
		scrap.global_position=global_position
		get_tree().current_scene.add_child(scrap)
		
		var deathSound=plDeathSound.instantiate()
		deathSound.global_position=global_position
		get_tree().current_scene.add_child(deathSound)
		
		
		var explosionEffect=plEnemyExplosion.instantiate()
		explosionEffect.global_position=global_position
		get_tree().current_scene.add_child(explosionEffect)
		queue_free()
func PlayAnimation():

	if $FireTimer.time_left<0.35:
		$FiringPositions/LeftGun.play("shooting")
		$FiringPositions/RightGun.play("shooting")
	else:
		$FiringPositions/LeftGun.play("not shooting")
		$FiringPositions/RightGun.play("not shooting")
		
