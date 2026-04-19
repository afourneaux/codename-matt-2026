extends Control

@onready var play = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Play as Button
@onready var quit = $MarginContainer/HBoxContainer/VBoxContainer/Quit as Button
@onready var jouer = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Jouer as Button

var load_game = preload("res://scenes/game-root.tscn") as PackedScene

func _ready():
	play.text = "play_button"
	quit.text = "quit_button"
	play.pressed.connect(_on_play_pressed)
	jouer.pressed.connect(_on_jouer_pressed)
	quit.pressed.connect(_on_quit_pressed)
	Audio.play_bg_music("white_noise")

func _on_play_pressed():
	TranslationServer.set_locale("en")
	get_tree().change_scene_to_packed(load_game)

func _on_jouer_pressed():
	TranslationServer.set_locale("fr")
	get_tree().change_scene_to_packed(load_game)

func _on_quit_pressed():
	get_tree().quit()
