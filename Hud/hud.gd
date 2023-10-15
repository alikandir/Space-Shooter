extends Control

@onready var lifeContainer:=$LifeContainer
@onready var scoreLabel:=$Score
@onready var levelLabel=$Level


var plLevelUpScreen=preload("res://MainScenes/level_up_screen.tscn")
@onready var plSettingsScreen=preload("res://MainScenes/setting_menu.tscn")



func _ready():
	ClearLives()
	Signals.connect("on_player_life_changed", Callable(self,"_on_player_life_changed"))
	Signals.connect("on_score_increment",Callable(self,"_on_score_increment"))
	levelLabel.text="Lvl " + str(PlayerStats.playerLevel)

func ClearLives():

	$LifeContainer/Lives.text="x 0"

func SetLives(lives:int):
	ClearLives()
	$LifeContainer/Lives.text="x " + str(lives)

func _on_player_life_changed(life:int):
	SetLives(life)
	
func _on_score_increment(amount:int):
	PlayerStats.score+=amount
	scoreLabel.text=str(PlayerStats.score)
	if PlayerStats.score>PlayerStats.highScore:
		PlayerStats.highScoreReached=true
		PlayerStats.highScore=PlayerStats.score
	var desiredScore
	
	### Calculate the desired score for the next level:
	if PlayerStats.playerLevel<5:
		desiredScore=pow(PlayerStats.playerLevel,1.5)*500
	elif PlayerStats.playerLevel<10:
		desiredScore=pow(PlayerStats.playerLevel,1.52)*500
	elif PlayerStats.playerLevel<15:
		desiredScore=pow(PlayerStats.playerLevel,1.55)*500
	elif PlayerStats.playerLevel<25:
		desiredScore=pow(PlayerStats.playerLevel,1.6)*500
	else:
		desiredScore=pow(PlayerStats.playerLevel,1.65)*500
	if PlayerStats.score>=desiredScore and PlayerStats.isAlive	:
		PlayerStats.level_up()
		levelLabel.text="Lvl " + str(PlayerStats.playerLevel)
		var levelUpScreen = plLevelUpScreen.instantiate()
		levelUpScreen.position = position
		get_parent().add_child(levelUpScreen)
		get_tree().paused = true
		







func _on_settings_pressed():

	var settingsScreen=plSettingsScreen.instantiate()
	settingsScreen.position=position
	get_tree().current_scene.add_child(settingsScreen)
	get_tree().paused=true
	
