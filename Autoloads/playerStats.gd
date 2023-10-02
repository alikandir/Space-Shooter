extends Node


var playerLevel:int=1

var fireDelay:float=0.5
var normalFireDelay = fireDelay
var rapidFireDelay: float = 0.1

var bulletUpgradeTimes:int=0

func level_up():
	playerLevel+=1

func processLevelUp(index:int):
	match index:
		0:
			### Fire rate up:
			fireDelay*=0.8
			if fireDelay < 0.1:  
				fireDelay = 0.1  # Minimum fire delay
		1:
			### +1 bullets
			bulletUpgradeTimes+=1
			Signals.emit_signal("on_bullets_upgraded",bulletUpgradeTimes)
			
		2:
			### Extend shield power up timer
			pass 
		3:
			### +1 Life
			pass
		4:
			### Move speed up
			pass
		5:
			### Damage up
			pass
		6:
			### Power ups spawn faster
			pass
		7:
			### More experience gain
			pass
		8:
			### Dodge chance increased
			pass

