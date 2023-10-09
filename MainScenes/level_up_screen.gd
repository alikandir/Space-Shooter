extends Control

@onready var button1 = $HBoxContainer/Button1
@onready var button2 = $HBoxContainer/Button2
@onready var button3 = $HBoxContainer/Button3
@onready var label1 = $HBoxContainer/Button1/Label1
@onready var label2 = $HBoxContainer/Button2/Label2
@onready var label3 = $HBoxContainer/Button3/Label3


var upgradeOptionsString = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
### pick a random upgrade
	var choosenOptions=[]
	
	while choosenOptions.size()<3:
		var randomIndex = randi() % UpgradeOptions.upgradeOptions.size()
		var choosenUpgrade = UpgradeOptions.upgradeOptions[randomIndex]
		## ensure no duplicates:
		if choosenUpgrade not in choosenOptions:
			choosenOptions.append(UpgradeOptions.upgradeOptions[randomIndex])
			upgradeOptionsString.append(UpgradeOptions.upgradeOptions[randomIndex])

### change the button text

	label1.text = choosenOptions[0]
	label2.text = choosenOptions[1]
	label3.text = choosenOptions[2]




func _on_button_1_pressed():
	get_tree().paused=false
	PlayerStats.processLevelUp(upgradeOptionsString[0])
	queue_free()


func _on_button_2_pressed():
	get_tree().paused=false
	PlayerStats.processLevelUp(upgradeOptionsString[1])
	queue_free()

func _on_button_3_pressed():
	get_tree().paused=false
	PlayerStats.processLevelUp(upgradeOptionsString[2])
	queue_free()



