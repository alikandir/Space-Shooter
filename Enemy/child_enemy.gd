extends Enemy
var playerPosition:Vector2
var foundTarget:bool=false
var velocity: Vector2
var plHitSound=preload("res://SFX/hit_sound.tscn")
var plDeathSound=preload("res://SFX/death_sound_enemy.tscn")
@onready var hit_flash_anim=$HitFlashAnimation
@export var moveSpeed:float =5
func _ready():
	health=PlayerStats.enemyHealths["smallEnemyHealth"]
	$InitialTimer.start()
	Signals.connect("player_position",Callable(self,"get_player_position"))

func _process(delta):
	if !foundTarget and $InitialTimer.is_stopped():
		foundTarget=true
		look_at(playerPosition)
		var rotation_rad = deg_to_rad(rotation_degrees)
		velocity.x = cos(rotation_rad)
		velocity.y = sin(rotation_rad)
		velocity *= moveSpeed
	
	if foundTarget:
		position+=velocity*delta
	
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
		
		var scrap=plScrapSmall.instantiate()
		scrap.global_position=global_position
		get_tree().current_scene.add_child(scrap)
		queue_free()
func get_player_position(PlayerPosition):
	playerPosition=PlayerPosition

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
