extends Area2D
class_name Enemy
@onready var firingPositions:=$FiringPositions
@onready var plBullet:=preload("res://Bullet/enemyBullet.tscn")
@onready var plEnemyExplosion:=preload("res://Enemy/enemy_explosion.tscn")

@export var verticalSpeed:float=10
@export var health:int=5
var playerInArea:Player=null

func _physics_process(delta):
	Move(delta)
	if playerInArea !=null:
		playerInArea.damage(1)

func Move(delta):
	position.y+=verticalSpeed*delta
	

func Shoot():
	for child in firingPositions.get_children():
		var bullet = plBullet.instantiate()
		bullet.global_position=child.global_position
		get_tree().current_scene.add_child(bullet)

func damage(amount:int):
	if health<=0:
		return
	health-=amount
	if health<=0:
		var explosionEffect=plEnemyExplosion.instantiate()
		explosionEffect.global_position=global_position
		get_tree().current_scene.add_child(explosionEffect)
		Signals.emit_signal("on_score_increment",10)
		queue_free()
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		playerInArea=area


func _on_area_exited(area):
	if area is Player:
		playerInArea=null
