extends CharacterBody2D

const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func interaction():
	pass

func get_input():
	var input = Input.get_vector("a", "d", "w", "s")
	velocity = input * SPEED

	if velocity.x < 0:
		sprite.flip_h = true

	else:
		sprite.flip_h = false

func _physics_process(delta):
	get_input()
	interaction()
	move_and_slide()
