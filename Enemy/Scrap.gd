extends Area2D
class_name Scrap
@export var moveSpeed:float
# Called when the node enters the scene tree for the first time.
func _ready():
	$Scrap.play("default")
	$Scrap/Shield.play("default")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y+=moveSpeed*delta


func _on_area_entered(area):
	if area is Player:
		Signals.emit_signal("on_score_increment",PlayerStats.basicEnemyScore)
		queue_free()
