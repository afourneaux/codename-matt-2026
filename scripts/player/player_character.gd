extends CharacterBody2D
signal on_interact

const SPEED = 200.0
const IS_PLAYER = true
var audio = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func interaction():
	pass

func _ready():
	var animation = get_animation_name()
	sprite.play(animation)
	sprite.stop()
	

func _exit_tree() -> void:
	if audio:
		Audio.stop_sfx(audio)

func get_input():
	var input = Input.get_vector("a", "d", "w", "s")
	velocity = input * SPEED
	var animation = get_animation_name()

	if velocity:
		if not audio:
			audio = Audio.play_sfx("footsteps", true)
		if velocity.x < 0:
			sprite.play(animation)
			sprite.flip_h = true

		elif velocity.x > 0:
			sprite.play(animation)
			sprite.flip_h = false
		
		elif velocity.y:
			sprite.play(animation)
	else:
		if audio:
			Audio.stop_sfx(audio)
			audio = false
		sprite.stop()
	if GameState.current_room_id == 3:
		# doppy room, handle z index
		z_index = int(position.y / 20) + 10

func get_animation_name():
	return "endgame" if GameState.is_endgame() else "walking"

func _input(event):
	if GameState.freeze_inputs():
		if audio:
			Audio.stop_sfx(audio)
			audio = false
		return
	if event.is_action_pressed("interact"):
		on_interact.emit()

func _physics_process(delta):
	if GameState.freeze_inputs():
		return
	get_input()
	interaction()
	move_and_slide()
