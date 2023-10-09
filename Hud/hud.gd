extends Control

@onready var lifeContainer:=$LifeContainer
@onready var scoreLabel:=$Score
@onready var levelLabel=$Level

var plLifeIcon=preload("res://Hud/life_icon.tscn")
var plLevelUpScreen=preload("res://MainScenes/level_up_screen.tscn")



func _ready():
	ClearLives()
	Signals.connect("on_player_life_changed", Callable(self,"_on_player_life_changed"))
	Signals.connect("on_score_increment",Callable(self,"_on_score_increment"))
	levelLabel.text="Lvl " + str(PlayerStats.playerLevel)

func ClearLives():
	for child in lifeContainer.get_children():
		## remove_child does not automatically remove it from the scene!!
		lifeContainer.remove_child(child)
		child.queue_free()

func SetLives(lives:int):
	ClearLives()
	for i in range(lives):
		lifeContainer.add_child(plLifeIcon.instantiate())

func _on_player_life_changed(life:int):
	SetLives(life)
	
func _on_score_increment(amount:int):
	PlayerStats.score+=amount
	scoreLabel.text=str(PlayerStats.score)
	
	### Calculate the desired score for the next level:
	var desiredScore=pow(PlayerStats.playerLevel,1.5)*50
	
	if PlayerStats.score>=desiredScore:
		PlayerStats.level_up()
		levelLabel.text="Lvl " + str(PlayerStats.playerLevel)
		var levelUpScreen = plLevelUpScreen.instantiate()
		levelUpScreen.position = position
		get_parent().add_child(levelUpScreen)
		get_tree().paused = true
		





