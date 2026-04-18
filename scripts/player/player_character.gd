extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func get_input():
	var input = Input.get_vector("a", "d", "w", "s")
	velocity = input * SPEED

	if velocity.x < 0:
		sprite.flip_h = true
		print("Moving left")
	else:
		sprite.flip_h = false
		print("Moving right")

func _physics_process(delta):
	get_input()
	move_and_slide()
