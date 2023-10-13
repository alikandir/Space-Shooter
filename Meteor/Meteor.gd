extends Area2D
class_name Meteor
@export var minSpeed:float=10
@export var maxSpeed:float=10

@export var minRotationRate:float=-10
@export var maxRotationRate:float=10
@onready var meteorHealth= PlayerStats.enemyHealths["toughEnemyHealth"]
@onready var hit_flash_anim=$HitFlash

var plHitSound=preload("res://SFX/hit_sound.tscn")
var plDeathSound=preload("res://SFX/death_sound_enemy.tscn")
var plMeteorEffect:=preload("res://Meteor/meteor_effect.tscn")
var speed:float=0
var rotationRate=0
var playerInArea:Player=null

func _ready():
	speed=randf_range(minSpeed,maxSpeed)
	rotationRate=randf_range(minRotationRate,maxRotationRate)

func _process(delta):
	if playerInArea !=null:
		playerInArea.damage(1)
func _physics_process(delta):
	position.y+=speed*delta
	
	rotation_degrees+=rotationRate*delta

func damage(amount:float):
	if meteorHealth<=0:
		return
	meteorHealth-=amount
	hit_flash_anim.play("hit_flash")
	var hitSound=plHitSound.instantiate()
	hitSound.position=position
	get_tree().current_scene.add_child(hitSound)
	
	if meteorHealth<=0:
		var deathSound=plDeathSound.instantiate()
		deathSound.global_position=global_position
		get_tree().current_scene.add_child(deathSound)
		
		
		var effect:=plMeteorEffect.instantiate()
		effect.position=position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_increment",PlayerStats.meteorScore)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		playerInArea=area



func _on_area_exited(area):
	if area is Player:
		playerInArea=null

