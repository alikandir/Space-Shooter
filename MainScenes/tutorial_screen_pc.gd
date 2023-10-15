extends Control



@onready var arrayToBeVisible=[
	$WASD,
	$WASD/Or,
	$CanvasLayer/Touch,
	$CanvasLayer/Collect,
	$"CanvasLayer/Power Ups",
	$CanvasLayer/OkButton
]
var arrayIndex:int=0
var countDown:float=1
# Called when the node enters the scene tree for the first time.
func _ready():
	$WASD/AnimationPlayer.play("WASD")
	$CanvasLayer/Touch/AnimationPlayer.play("touch_anim")
	$CanvasLayer/Collect.play("default")
	$CanvasLayer/Collect/Collect2.play("default")
	$"CanvasLayer/Power Ups".play("default")
	$"CanvasLayer/Power Ups/Power Ups2".play("default")
	$"CanvasLayer/Power Ups/Power Ups3".play("default")




func _on_ok_button_pressed():
	get_tree().change_scene_to_file("res://MainScenes/gameplay.tscn")



func _on_timer_timeout():
	arrayToBeVisible[arrayIndex].visible=true
	arrayIndex+=1
	if arrayIndex<arrayToBeVisible.size():
		$Timer.start(countDown)
	else:
		$Timer.stop()
