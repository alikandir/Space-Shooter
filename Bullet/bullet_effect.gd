extends Sprite2D



func _on_bullet_effect_timer_timeout():
	queue_free()
