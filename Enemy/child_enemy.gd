extends Enemy
var playerPosition:Vector2
var foundTarget:bool=false
var velocity: Vector2

@export var moveSpeed:float =5
func _ready():
	$InitialTimer.start()
	Signals.connect("player_position",Callable(self,"get_player_position"))

func _process(delta):
	if !foundTarget and $InitialTimer.is_stopped():
		foundTarget=true
		look_at(playerPosition)
		var rotation_rad = deg_to_rad(rotation_degrees)
		velocity.x = cos(rotation_rad)
		velocity.y = sin(rotation_rad)
		velocity *= moveSpeed
	
	if foundTarget:
		position+=velocity*delta
	
func _on_area_entered(area):
	if area is Player:
		playerInArea=area


func _on_area_exited(area):
	if area is Player:
		playerInArea=null
func damage(amount:int):
	if health<=0:
		return
	health-=amount
	if health<=0:
		var scrap=plScrapSmall.instantiate()
		scrap.global_position=global_position
		get_tree().current_scene.add_child(scrap)
		queue_free()
func get_player_position(PlayerPosition):
	playerPosition=PlayerPosition
