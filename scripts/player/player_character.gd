extends CharacterBody2D

const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast: RayCast2D = $RayCast2D

func interaction():
	var interact = Input.is_action_pressed("interact")
	if interact:
		print("Interacting with the environment")

func get_input():
	var input = Input.get_vector("a", "d", "w", "s")
	velocity = input * SPEED

	if velocity.x < 0:
		sprite.flip_h = true
		raycast.target_position = Vector2(-16, 0)
		print("raycast target position: ", raycast.target_position)
	else:
		sprite.flip_h = false
		raycast.target_position = Vector2(16, 0)
		print("raycast target position: ", raycast.target_position)
	
	if velocity.y < 0:
		raycast.target_position = Vector2(0, -16)
		print("raycast target position: ", raycast.target_position)
	elif velocity.y > 0:
		raycast.target_position = Vector2(0, 16)
		print("raycast target position: ", raycast.target_position)

func _physics_process(delta):
	get_input()
	interaction()
	move_and_slide()
