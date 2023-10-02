extends Area2D
class_name Meteor
@export var minSpeed:float=10
@export var maxSpeed:float=10

@export var minRotationRate:float=-10
@export var maxRotationRate:float=10
@export var meteorHealth:int=20

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

func damage(amount:int):
	if meteorHealth<=0:
		return
	meteorHealth-=amount
	if meteorHealth<=0:
		var effect:=plMeteorEffect.instantiate()
		effect.position=position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_increment",20)
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Player:
		playerInArea=area



func _on_area_exited(area):
	if area is Player:
		playerInArea=null

