extends Enemy

var plRocket=preload("res://Enemy/Rocket.tscn")
var inPlace:bool=false
var fireDelay:float=3
@onready var hit_flash_anim=$HitFlashAnimation
var plHitSound=preload("res://SFX/hit_sound.tscn")
var plDeathSound=preload("res://SFX/death_sound_enemy.tscn")
func _ready():
	plBullet=preload("res://Enemy/Rocket.tscn")
	$ShipSprite.play("default")
	health=PlayerStats.enemyHealths["bigEnemyHealth"]


func _physics_process(delta):
	if !inPlace:
		position.y+=delta*verticalSpeed*10
		if position.y>100:
			inPlace=true
			canShoot=true

	CollisionDamage()
	if $FireTimer.is_stopped():
		Shoot()
		$FireTimer.start(fireDelay)
		
	
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

func _on_fire_timer_timeout():
	pass # Replace with function body.
