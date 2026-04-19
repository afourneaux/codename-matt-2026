extends Node2D
signal completed


func _enter_tree() -> void:
	GameState.in_minigame = true
	

func _input(event):
	if event.is_action_pressed("interact"):
		get_viewport().set_input_as_handled()
		GameState.in_minigame = false # must be before completed.emit()
		completed.emit()
		
