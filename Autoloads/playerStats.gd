extends Node
var highScore:int
var score:int=0
var playerLevel:int=1
var highScoreReached:bool=false
var isAlive:bool=true
@export var playerHealth:int=3
@export var shieldTime:float=5
@export var invincibilityTime:float=1
@export var moveSpeed: float=240
@export var playerDamage:float=1
var fireDelay:float=0.4
var normalFireDelay 
var rapidFireDelay: float = 0.06

@export var minPowerupSpawnTime:=10.0
@export var maxPowerupSpawnTime:=20.0

var bulletUpgradeTimes:int=0
## scores:
var bigEnemyScore:float=200
var basicEnemyScore:float=75
var meteorScore:float=300

@export var dodgeChance:float=0
var maxDodgeChance:float=0.7

var enemyHealths:Dictionary={"smallEnemyHealth":2.0, "midEnemyHealth":10.0, "bigEnemyHealth":14.0, "toughEnemyHealth":16.0}
func _ready():
	var saveFile=FileAccess.open("user://save.data",FileAccess.READ)
	if saveFile!=null:
		highScore=saveFile.get_32()
	else:
		highScore=0
		SaveGame()

func level_up():
	playerLevel+=1

func processLevelUp(LevelUpName:String):
	increase_enemy_health()
	print_debug(enemyHealths)
	
	match LevelUpName:
		"Fire Rate Up":
			### Fire rate up:
			fireDelay*=0.8
			if fireDelay < 0.1:  
				fireDelay = 0.1  # Minimum fire delay
		"+2 Bullets, -30% Damage Down":
			### +2 bullets
			bulletUpgradeTimes+=1
			Signals.emit_signal("on_bullets_upgraded",bulletUpgradeTimes)
			
		"Extend Shield Power-up Timer":
			### Extend shield power up timer
			shieldTime+=1
			invincibilityTime+=0.5
		"+1 Life":
			### +1 Life
			playerHealth+=1
			Signals.emit_signal("on_player_life_changed",playerHealth)
		"Move Speed Up":
			### Move speed up
			moveSpeed+=70
			if moveSpeed>700:
				moveSpeed=700
		"Damage Up":
			### Damage up
			playerDamage+=0.8
		"Power-ups Spawn Faster":
			### Power ups spawn faster
			minPowerupSpawnTime-=0.8
			maxPowerupSpawnTime-=0.8
			if minPowerupSpawnTime<3:
				minPowerupSpawnTime=3
			if maxPowerupSpawnTime<4:
				maxPowerupSpawnTime=4
		"More Experience Gain":
			### More experience gain
			meteorScore*=1.10
			basicEnemyScore*=1.10
			bigEnemyScore*=1.10
		"Dodge Chance Increased":
			### Dodge chance increased
			dodgeChance+=0.15
			if dodgeChance>=maxDodgeChance:
				dodgeChance=maxDodgeChance
				Signals.emit_signal("dodge_capacity_reached",true)

func reset_game():
	isAlive=true
	score=0
	playerLevel=1
	playerHealth=3
	shieldTime=5
	invincibilityTime=1
	moveSpeed=240
	playerDamage=1
	fireDelay=0.4
	rapidFireDelay= 0.06
	minPowerupSpawnTime=10
	maxPowerupSpawnTime=20
	bulletUpgradeTimes=0
## scores:
	bigEnemyScore=200
	basicEnemyScore=75
	meteorScore=300

	dodgeChance=0
	maxDodgeChance=0.7
	enemyHealths={"smallEnemyHealth":2.0, "midEnemyHealth":10.0, "bigEnemyHealth":14.0, "toughEnemyHealth":16.0}
	highScoreReached=false
func increase_enemy_health():
	if playerLevel>50:
		for key in enemyHealths.keys():
			enemyHealths[key]*=1.20
	elif playerLevel>30:
		for key in enemyHealths.keys():
			enemyHealths[key]*=1.15
	elif playerLevel>15:
		for key in enemyHealths.keys():
			enemyHealths[key]*=1.1
	elif playerLevel>10:
		for key in enemyHealths.keys():
			enemyHealths[key]*=1.2
	elif playerLevel>3:
		for key in enemyHealths.keys():
			enemyHealths[key]*=1.05
	elif playerLevel>0:
		for key in enemyHealths.keys():
			enemyHealths[key]*=1.05
func SaveGame():
	
	var saveFile=FileAccess.open("user://save.data",FileAccess.WRITE)
	saveFile.store_32(highScore)
