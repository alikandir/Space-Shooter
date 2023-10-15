extends Node2D


@onready var spawnTimer=$SpawnTimer
@onready var powerupSpawnTimer=$PowerupTimer
@onready var easySpawnTimer=$EasySpawnTimer

var preloadedEnemies:=[
	preload("res://Enemy/slow_bouncer_enemy.tscn"),
	preload("res://Enemy/bouncerEnemyCrossMoving.tscn"),
	preload("res://Enemy/bouncerEnemy.tscn"),
	preload("res://Enemy/enemy_targeting_shooter.tscn"),
	preload("res://Enemy/mother_enemy.tscn"),
	preload("res://Enemy/buzzsaw_enemy.tscn"),
	preload("res://Enemy/rocket_thrower.tscn")
]

var preloadedEasyEnemies:=[
	preload("res://Enemy/buzzsaw_enemy_easy.tscn"),
	preload("res://Enemy/cross_moving_bouncer_enemy_easy.tscn")
	
]

var preloadedPowerups:=[
	preload("res://Powerups/shield_power_up.tscn"),
	preload("res://Powerups/rapid_fire_power_up.tscn"),
]
var plExtraLife=preload("res://Powerups/extra_life_power_up.tscn")
var plMeteor=preload("res://Meteor/Meteor.tscn")

var firstSpawnTime:float=2.0
var easySpawnTime:float=2.5
var nextSpawnTime:float=10


@export var minSpawnTime:float=6.0



func _ready():
	randomize()
	easySpawnTimer.start(easySpawnTime)
	spawnTimer.start(nextSpawnTime)
	powerupSpawnTimer.start(minSpawnTime)
	

func _on_spawn_timer_timeout():
	var minSpawnAmount:int
	var maxSpawnAmount:int
	
	if PlayerStats.playerLevel>35:
		minSpawnAmount=2
		maxSpawnAmount=5

	elif PlayerStats.playerLevel>30:
		minSpawnAmount=2
		maxSpawnAmount=5

		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()

	elif PlayerStats.playerLevel>25:
		minSpawnAmount=2
		maxSpawnAmount=4

		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	if PlayerStats.playerLevel>20:
		minSpawnAmount=2
		maxSpawnAmount=3
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>15:
		minSpawnAmount=2
		maxSpawnAmount=3
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>10:
		minSpawnAmount=1
		maxSpawnAmount=2
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	elif PlayerStats.playerLevel>4:
		minSpawnAmount=1
		maxSpawnAmount=1
		for i in randi_range(minSpawnAmount,maxSpawnAmount):
			Spawn()
	else:
		pass
	#restart the timer
	nextSpawnTime-=0.05
	print_debug(nextSpawnTime)
	if nextSpawnTime<minSpawnTime:
		nextSpawnTime=minSpawnTime
	spawnTimer.start(nextSpawnTime)


func _on_powerup_timer_timeout():
	powerupSpawnTimer.start(randf_range(PlayerStats.minPowerupSpawnTime,PlayerStats.maxPowerupSpawnTime))
	if randf()<0.08:
		var extraLife=plExtraLife.instantiate()
		extraLife.position=getRandomSpawnPos()
		get_tree().current_scene.add_child(extraLife)
#		powerupSpawnTimer.start(randf_range(PlayerStats.minPowerupSpawnTime,PlayerStats.maxPowerupSpawnTime))
	else:
		var powerupPreload= preloadedPowerups[randi()%preloadedPowerups.size()]
		var powerup=powerupPreload.instantiate()
		powerup.position = getRandomSpawnPos()
		get_tree().current_scene.add_child(powerup)
#		powerupSpawnTimer.start(randf_range(PlayerStats.minPowerupSpawnTime,PlayerStats.maxPowerupSpawnTime))

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

func SpawnEasy():
	var enemyPreload=preloadedEasyEnemies[randi()%preloadedEasyEnemies.size()]
	var enemy:Enemy= enemyPreload.instantiate()
	enemy.position=getRandomSpawnPos()
	get_tree().current_scene.add_child(enemy)


func _on_easy_spawn_timer_timeout():
	var minSpawnEasyAmount:int
	var maxSpawnEasyAmount:int
	
	if PlayerStats.playerLevel>30:
		minSpawnEasyAmount=5
		maxSpawnEasyAmount=10
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	elif PlayerStats.playerLevel>25:

		minSpawnEasyAmount=4
		maxSpawnEasyAmount=9
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	if PlayerStats.playerLevel>20:
		minSpawnEasyAmount=4
		maxSpawnEasyAmount=7
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	elif PlayerStats.playerLevel>15:
		minSpawnEasyAmount=1
		maxSpawnEasyAmount=4
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	elif PlayerStats.playerLevel>10:
		minSpawnEasyAmount=2
		maxSpawnEasyAmount=4
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	elif PlayerStats.playerLevel>5:
		minSpawnEasyAmount=1
		maxSpawnEasyAmount=5
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	elif PlayerStats.playerLevel>3:
		minSpawnEasyAmount=2
		maxSpawnEasyAmount=4
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
	elif PlayerStats.playerLevel>0:
		minSpawnEasyAmount=1
		maxSpawnEasyAmount=2
		for i in randi_range(minSpawnEasyAmount,maxSpawnEasyAmount):
			SpawnEasy()
			
	easySpawnTimer.start(easySpawnTime)
