extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func get_input():
	var input = Input.get_vector("a", "d", "w", "s")
	velocity = input * SPEED

func _physics_process(delta):
	get_input()
	move_and_slide()
