extends Control

@onready var flash_anim=$"CanvasLayer/Panel/High Score/Flash"
@onready var jump_anim=$"CanvasLayer/Panel/High Score/Jump"
@onready var cheerSound=$HighScoreAudioCheer
@onready var fireWorks=$FireworksAudio
# Called when the node enters the scene tree for the first time.
func _ready():
	if PlayerStats.highScoreReached:
		$"CanvasLayer/Panel/High Score".text = "NEW HIGH SCORE!\n" + str(PlayerStats.highScore)
		flash_anim.play("High Score")
		jump_anim.play("jump")
		cheerSound.playing=true
		fireWorks.playing=true
		$"CanvasLayer/Panel/High Score/CPUParticles2D".visible=true
		
	else :
		$"CanvasLayer/Panel/High Score".text = "HIGH SCORE:\n" + str(PlayerStats.highScore)
	$CanvasLayer/Panel/VBoxContainer/Score.text="Score:\n" + str(PlayerStats.score)
	$CanvasLayer/Panel/VBoxContainer/Level.text="Level Reached:\n " + str(PlayerStats.playerLevel)


func _on_retry_pressed():
	get_tree().reload_current_scene()
	PlayerStats.reset_game()
	UpgradeOptions.ResetGame()
	


func _on_quit_pressed():
	get_tree().quit()
