extends FastEnemy
var horizontalDirection:int=1
var horizontalSpeed=100
@onready var hit_flash_anim=$HitFlashAnimation
var plHitSound=preload("res://SFX/hit_sound.tscn")
var plDeathSound=preload("res://SFX/death_sound_enemy.tscn")
func _ready():
	health=PlayerStats.enemyHealths["smallEnemyHealth"]


func _process(delta):
	CollisionDamage()
	
	var viewRect=get_viewport_rect()
	if position.x<viewRect.position.x+35 or position.x>viewRect.end.x-35:
		horizontalDirection*=-1
	position.x+=horizontalSpeed*delta*horizontalDirection
	position.y+=verticalSpeed*delta*1.5

func damage(amount:float):
	if health<=0:
		return
	health-=amount
	var hitSound=plHitSound.instantiate()
	hitSound.position=position
	get_tree().current_scene.add_child(hitSound)
	hit_flash_anim.play("hit_flash")
	if health<=0:
		var deathSound=plDeathSound.instantiate()
		deathSound.global_position=global_position
		get_tree().current_scene.add_child(deathSound)
		
		var explosionEffect=plEnemyExplosion.instantiate()
		explosionEffect.global_position=global_position
		get_tree().current_scene.add_child(explosionEffect)
		var scrap=plScrapSmall.instantiate()
		scrap.global_position=global_position
		get_parent().add_child(scrap)
		queue_free()
