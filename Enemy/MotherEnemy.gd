extends Enemy

@onready var plChildEnemy=preload("res://Enemy/child_enemy.tscn")



func damage(amount:int):
	if health<=0:
		return
	health-=amount
	if health<=0:
		var scrap=plScrap.instantiate()
		scrap.global_position=global_position
		get_tree().current_scene.add_child(scrap)
		
		var childEnemy1=plChildEnemy.instantiate()
		childEnemy1.position=position
		var childEnemy2=plChildEnemy.instantiate()
		childEnemy2.position=position+Vector2(-20,-20)
		var childEnemy3=plChildEnemy.instantiate()
		childEnemy3.position=position+Vector2(30,30)
		var childEnemy4=plChildEnemy.instantiate()
		childEnemy4.position=position+Vector2(20,20)
		var childEnemy5=plChildEnemy.instantiate()
		childEnemy5.position=position
		get_parent().add_child(childEnemy1)
		get_parent().add_child(childEnemy2)
		get_parent().add_child(childEnemy3)
		get_parent().add_child(childEnemy4)
		get_parent().add_child(childEnemy5)
		queue_free()
		
func _on_area_entered(area):
	if area is Player:
		playerInArea=area


func _on_area_exited(area):
	if area is Player:
		playerInArea=null
