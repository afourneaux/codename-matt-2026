extends Node2D
signal completed


func _enter_tree() -> void:
	GameState.in_mini_game = true

func _exit_tree():
	GameState.in_mini_game = false

func _input(event):
	if event.is_action_pressed("interact"):
		completed.emit()
				
func _ready():
	if GameState.task_completion[2]:
		queue_free()
