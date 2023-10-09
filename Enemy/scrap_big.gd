extends Scrap

func _process(delta):
	position.y+=moveSpeed*delta

func _on_area_entered(area):
	if area is Player:
		Signals.emit_signal("on_score_increment",PlayerStats.bigEnemyScore)
		queue_free()
