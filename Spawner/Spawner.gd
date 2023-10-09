extends Node2D


@onready var spawnTimer=$SpawnTimer
@onready var powerupSpawnTimer=$PowerupTimer

var preloadedEnemies:=[
	preload("res://Enemy/slow_bouncer_enemy.tscn"),
	preload("res://Enemy/bouncerEnemyCrossMoving.tscn"),
	preload("res://Enemy/bouncerEnemy.tscn"),
	preload("res://Enemy/enemy_targeting_shooter.tscn"),
	preload("res://Enemy/mother_enemy.tscn"),
	preload("res://Enemy/buzzsaw_enemy.tscn"),
	preload("res://Enemy/rocket_thrower.tscn")
]

var preloadedPowerups:=[
	preload("res://Powerups/shield_power_up.tscn"),
	preload("res://Powerups/rapid_fire_power_up.tscn"),
]
var plMeteor=preload("res://Meteor/Meteor.tscn")

@export var nextSpawnTime:=5.0
@export var minSpawnTime:float=2.0



func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)
	powerupSpawnTimer.start(minSpawnTime)

func _on_spawn_timer_timeout():
	var minSpawnAmount:int
	var maxSpawnAmount:int
	if PlayerStats.playerLevel>20:
		minSpawnAmount=5
		maxSpawnAmount=7
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>15:
		minSpawnAmount=4
		maxSpawnAmount=5
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>10:
		minSpawnAmount=3
		maxSpawnAmount=4
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>5:
		minSpawnAmount=1
		maxSpawnAmount=2
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>0:
		Spawn()
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
	powerupSpawnTimer.start(randf_range(PlayerStats.minPowerupSpawnTime,PlayerStats.maxPowerupSpawnTime))

func getRandomSpawnPos():
	## spawn an enemy
	var viewRect= get_viewport_rect()
	var xPos=randf_range(viewRect.position.x+50,viewRect.end.x-50)
	return Vector2(xPos,position.y)

func Spawn():
		
	if randf()<0.1:
		var meteor: Meteor=plMeteor.instantiate()
		meteor.position=getRandomSpawnPos()
		get_tree().current_scene.add_child(meteor)
	
	else:
		var enemyPreload=preloadedEnemies[randi()%preloadedEnemies.size()]
		var enemy:Enemy= enemyPreload.instantiate()
		enemy.position=getRandomSpawnPos()
		get_tree().current_scene.add_child(enemy)
		
