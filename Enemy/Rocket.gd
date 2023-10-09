extends Enemy

var plExplosion=preload("res://Enemy/explosionEffect.tscn")
var playerPosition:Vector2
var velocity:Vector2
@export var speed = 150
@export var countdown:float=2

func _ready():
	$Countdown.start(countdown)
	Signals.connect("player_position",Callable(self,"get_player_position"))
	$AnimatedSprite2D.play("default")
func _process(delta):
	look_at(playerPosition)
	var rotation_rad = deg_to_rad(rotation_degrees)
	velocity.x = cos(rotation_rad)
	velocity.y = sin(rotation_rad)
	velocity *= speed
	position+=velocity*delta
func _on_area_entered(area):
	if area is Player:
		playerInArea=area
		var explosion = plExplosion.instantiate()
		explosion.position=position
		get_parent().add_child(explosion)
		queue_free()


func _on_area_exited(area):
	if area is Player:
		playerInArea=null 

func get_player_position(PlayerPosition):
	playerPosition = PlayerPosition


func _on_countdown_timeout():
	var explosion = plExplosion.instantiate()
	explosion.position=position
	get_parent().add_child(explosion)
	queue_free()
