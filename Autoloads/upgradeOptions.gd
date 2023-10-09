extends Node


var upgradeOptions:Array=["Fire rate up", 
"+1 bullets",
"Extend shield power up timer ",
"+1 Life",
"Move speed up",
"Damage up",
"Power ups spawn faster",
"More experience gain",
"Dodge chance increased"
]
func _ready():
	Signals.connect("dodge_capacity_reached",Callable(self,"on_dodge_capacity_reached"))
# connect to bullet amount signal:
	Signals.connect("bullet_capacity_reached",Callable(self,"on_bullet_capacity_reached"))

func on_dodge_capacity_reached(bool):
	if true:
		upgradeOptions.erase("Dodge chance increased")

func on_bullet_capacity_reached(bulletLimit:bool):
	if bulletLimit:
		UpgradeOptions.upgradeOptions.erase("+1 bullets")

