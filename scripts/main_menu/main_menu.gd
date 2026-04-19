extends Control

@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/Play as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button

var load_game = preload("res://scenes/game-root.tscn") as PackedScene

func _ready():
	play.pressed.connect(_on_play_pressed)
	quit.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_packed(load_game)
	
func _on_quit_pressed():
	get_tree().quit()
