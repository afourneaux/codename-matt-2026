extends Node2D

signal completed

func _enter_tree() -> void:
	GameState.in_mini_game = true

func _exit_tree():
	GameState.in_mini_game = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
