extends Control


# Called when the node enters the scene tree for the first time.
func _ready():

	$CanvasLayer/Panel/VBoxContainer/Label2.text="Score:\n" + str(PlayerStats.score)
	$CanvasLayer/Panel/VBoxContainer/Label3.text="Level Reached:" + str(PlayerStats.playerLevel)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retry_pressed():
	get_tree().reload_current_scene()
	PlayerStats.reset_game()
	


func _on_quit_pressed():
	get_tree().quit()
