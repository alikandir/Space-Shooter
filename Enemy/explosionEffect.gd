extends Enemy


@onready var explosionTimer=$"Explosion Timer"
func _ready():
	$AnimatedSprite2D.play("default")
	var plBoomSound=preload("res://SFX/boom_sound_explosion.tscn")
	var boomSound=plBoomSound.instantiate()
	boomSound.global_position=global_position
	get_parent().add_child(boomSound)

func _process(delta):

	if explosionTimer.is_stopped():
		queue_free()
		
func _on_area_entered(area):
	if area is Player:
		playerInArea=area


func _on_area_exited(area):
	if area is Player:
		playerInArea=null
