extends CharacterBody2D

const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func interaction():
	pass

func get_input():
	var input = Input.get_vector("a", "d", "w", "s")
	velocity = input * SPEED

	if velocity:
		if velocity.x < 0:
			sprite.play("walking")
			sprite.flip_h = true

		elif velocity.x > 0:
			sprite.play("walking")
			sprite.flip_h = false
		
		elif velocity.y:
			sprite.play("walking")
	else:
		sprite.stop()

func _physics_process(delta):
	get_input()
	interaction()
	move_and_slide()
