extends FastEnemy

var playerPosition:Vector2
var foundTarget:bool=false
var velocity:Vector2
var startChasing=false
@export var moveSpeed:float=100
@onready var hit_flash_anim=$HitFlashAnimation
var plHitSound=preload("res://SFX/hit_sound.tscn")
var plDeathSound=preload("res://SFX/death_sound_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")
	rotationRate=120
	Signals.connect("player_position",Callable(self,"get_player_position"))
	health=PlayerStats.enemyHealths["smallEnemyHealth"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	CollisionDamage()
	rotate(deg_to_rad(rotationRate)*delta)
	if position.y<=250:
		position.y+=verticalSpeed*delta
	else:
		if !foundTarget:
			foundTarget=true
			look_at(playerPosition)
			var rotation_rad = deg_to_rad(rotation_degrees)
			velocity.x = cos(rotation_rad)
			velocity.y = sin(rotation_rad)
			velocity *= moveSpeed
			
	if startChasing:
		position+=velocity*delta
	

func get_player_position(PlayerPosition):
	playerPosition=PlayerPosition


func _on_timer_timeout():
	startChasing=true
	



func _on_area_entered(area):
	if area is Player:
		playerInArea=area


func _on_area_exited(area):
	if area is Player:
		playerInArea=null

func damage(amount:float):
	if health<=0:
		return
	health-=amount
	hit_flash_anim.play("hit_flash")
	var hitSound=plHitSound.instantiate()
	hitSound.position=position
	get_tree().current_scene.add_child(hitSound)
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

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
