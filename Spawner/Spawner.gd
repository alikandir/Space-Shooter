extends Node2D


@onready var spawnTimer=$SpawnTimer
@onready var powerupSpawnTimer=$PowerupTimer

var preloadedEnemies:=[
	preload("res://Enemy/bouncerEnemy.tscn"),
	preload("res://Enemy/slowShooter.tscn"),
	preload("res://Enemy/fast_enemy.tscn")
]

var preloadedPowerups:=[
	preload("res://Powerups/shield_power_up.tscn"),
	preload("res://Powerups/rapid_fire_power_up.tscn"),
]
var plMeteor=preload("res://Meteor/Meteor.tscn")

@export var nextSpawnTime:=5.0
@export var minSpawnTime:float=2.0

@export var minPowerupSpawnTime:=1
@export var maxPowerupSpawnTime:=3

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)
	powerupSpawnTimer.start(minSpawnTime)

func _on_spawn_timer_timeout():

	
	if randf()<0.15:
		var meteor: Meteor=plMeteor.instantiate()
		meteor.position=getRandomSpawnPos()
		get_tree().current_scene.add_child(meteor)
	
	else:
		var enemyPreload=preloadedEnemies[randi()%preloadedEnemies.size()]
		var enemy:Enemy= enemyPreload.instantiate()
		enemy.position=getRandomSpawnPos()
		get_tree().current_scene.add_child(enemy)
		
	#restart the timer
	nextSpawnTime-=0.1
	if nextSpawnTime<minSpawnTime:
		nextSpawnTime=minSpawnTime
	spawnTimer.start(nextSpawnTime)
func _on_powerup_timer_timeout():
	var powerupPreload= preloadedPowerups[randi()%preloadedPowerups.size()]
	var powerup:Powerup=powerupPreload.instantiate()
	powerup.position = getRandomSpawnPos()
	get_tree().current_scene.add_child(powerup)
	powerupSpawnTimer.start(randf_range(minPowerupSpawnTime,maxPowerupSpawnTime))

func getRandomSpawnPos():
	## spawn an enemy
	var viewRect= get_viewport_rect()
	var xPos=randf_range(viewRect.position.x,viewRect.end.x)
	return Vector2(xPos,position.y)
