extends Node
var score:int=0
var playerLevel:int=1

@export var playerHealth:int=3

@export var shieldTime:float=5
@export var invincibilityTime:float=1
@export var moveSpeed: float=200
@export var playerDamage:float=1
var fireDelay:float=0.5
var normalFireDelay 
var rapidFireDelay: float = 0.1

@export var minPowerupSpawnTime:=3
@export var maxPowerupSpawnTime:=7

var bulletUpgradeTimes:int=0
## scores:
var bigEnemyScore:float=20
var basicEnemyScore:float=10
var meteorScore:float=40

@export var dodgeChance:float=0
var maxDodgeChance:float=0.7


func level_up():
	playerLevel+=1

func processLevelUp(name:String):
	match name:
		"Fire rate up":
			### Fire rate up:
			fireDelay*=0.8
			if fireDelay < 0.1:  
				fireDelay = 0.1  # Minimum fire delay
		"+1 bullets":
			### +1 bullets
			bulletUpgradeTimes+=1
			Signals.emit_signal("on_bullets_upgraded",bulletUpgradeTimes)
			
		"Extend shield power up timer ":
			### Extend shield power up timer
			shieldTime+=5
			invincibilityTime+=0.5
		"+1 Life":
			### +1 Life
			playerHealth+=1
			Signals.emit_signal("on_player_life_changed",playerHealth)
		"Move speed up":
			### Move speed up
			moveSpeed+=70
		"Damage up":
			### Damage up
			playerDamage+=1
		"Power ups spawn faster":
			### Power ups spawn faster
			minPowerupSpawnTime-=1
			maxPowerupSpawnTime-=1
		"More experience gain":
			### More experience gain
			meteorScore*=1.3
			basicEnemyScore*=1.3
			bigEnemyScore*=1.3
		"Dodge chance increased":
			### Dodge chance increased
			dodgeChance+=0.15
			if dodgeChance>=maxDodgeChance:
				dodgeChance=maxDodgeChance
				Signals.emit_signal("dodge_capacity_reached",true)

func reset_game():
	score=0
	playerLevel=1
	playerHealth=3
	shieldTime=5
	invincibilityTime=1
	moveSpeed=200
	playerDamage=1
	fireDelay=0.5
	normalFireDelay 
	rapidFireDelay= 0.1
	minPowerupSpawnTime=3
	maxPowerupSpawnTime=7
	bulletUpgradeTimes=0
## scores:
	bigEnemyScore=20
	basicEnemyScore=10
	meteorScore=40

	dodgeChance=0
	maxDodgeChance=0.7
