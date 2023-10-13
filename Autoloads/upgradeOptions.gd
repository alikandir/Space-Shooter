extends Node


var upgradeOptions:Array=["Fire Rate Up", 
"+2 Bullets, -30% Damage Down",
"Extend Shield Power-up Timer",
"+1 Life",
"Move Speed Up",
"Damage Up",
"Power-ups Spawn Faster",
"More Experience Gain",
"Dodge Chance Increased"
]
func _ready():
	Signals.connect("dodge_capacity_reached",Callable(self,"on_dodge_capacity_reached"))
# connect to bullet amount signal:
	Signals.connect("bullet_capacity_reached",Callable(self,"on_bullet_capacity_reached"))

func on_dodge_capacity_reached(atCapacity:bool):
	if atCapacity:
		upgradeOptions.erase("Dodge chance increased")

func on_bullet_capacity_reached(bulletLimit:bool):
	if bulletLimit:
		UpgradeOptions.upgradeOptions.erase("+2 Bullets, -30% Damage Down")

func ResetGame():
	if "+2 Bullets, -30% Damage Down" not in upgradeOptions:
		upgradeOptions.append("+2 Bullets, -30% Damage Down")
	if  "Dodge chance increased" not in upgradeOptions:
		upgradeOptions.append("Dodge chance increased")
