extends Control

@onready var button1 = $HBoxContainer/Button1
@onready var button2 = $HBoxContainer/Button2
@onready var button3 = $HBoxContainer/Button3
@onready var label1 = $HBoxContainer/Button1/Label1
@onready var label2 = $HBoxContainer/Button2/Label2
@onready var label3 = $HBoxContainer/Button3/Label3

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
var upgradeOptionsIndex = []
# Called when the node enters the scene tree for the first time.
func _ready():
### pick a random upgrade
	var choosenOptions=[]
	
	while choosenOptions.size()<3:
		var randomIndex = randi()% upgradeOptions.size()
		var choosenUpgrade = upgradeOptions[randomIndex]
		## ensure no duplicates:
		if choosenUpgrade not in choosenOptions:
			choosenOptions.append(upgradeOptions[randomIndex])
			upgradeOptionsIndex.append(randomIndex)

### change the button text

	label1.text = choosenOptions[0]
	label2.text = choosenOptions[1]
	label3.text = choosenOptions[2]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_button_1_pressed():
	get_tree().paused=false
	PlayerStats.processLevelUp(upgradeOptionsIndex[0])
	queue_free()


func _on_button_2_pressed():
	get_tree().paused=false
	PlayerStats.processLevelUp(upgradeOptionsIndex[1])
	queue_free()

func _on_button_3_pressed():
	get_tree().paused=false
	PlayerStats.processLevelUp(upgradeOptionsIndex[2])
	queue_free()


	
