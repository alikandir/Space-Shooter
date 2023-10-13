extends Control

@onready var startButton=$CanvasLayer/VBoxContainer/StartButton
@onready var quitButton=$CanvasLayer/VBoxContainer/QuitButton
@onready var creditsButton=$CanvasLayer/HBoxContainer/CreditsButton
@onready var settingsButton=$CanvasLayer/HBoxContainer/SettingsButton

@onready var plSettingScene=preload("res://MainScenes/setting_menu.tscn")
@onready var canvasLayer=$CanvasLayer
@onready var plCreditsScene=preload("res://MainScenes/credits_scene.tscn")

func _ready():
	$CanvasLayer/PlayerSprite.play("Straight")
	$CanvasLayer/EnginesSprite.play("default")
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://MainScenes/gameplay.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_button_pressed():
	var settingsScene=plSettingScene.instantiate()
	settingsScene.global_position=global_position
	get_tree().current_scene.add_child(settingsScene)


func _on_credits_button_pressed():
	var creditsScene=plCreditsScene.instantiate()
	get_tree().current_scene.add_child(creditsScene)
