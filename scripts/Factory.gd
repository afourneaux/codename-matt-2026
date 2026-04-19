class_name Factory
extends Object


static var room_obj = preload("res://scenes/rooms/room.tscn")
static var character_obj = preload("res://scenes/player/player_character.tscn")
static var doppy_obj = preload("res://scenes/mini_games/doppy.tscn")
const ROOM_CENTRE = Vector2(550,550)

static var door_positions = {
	0: Vector2(450, 400),
	1: Vector2(700, 400),
	2: Vector2(700, 550),
	3: Vector2(450, 550)
}

static var room_data = {
	# Room 0 - beginning / end room
	0: {
		"links": {
			1: 1
		},
		"interactions": [
			{
				# sink
				"id": 2,
				"position": Vector2(600, 350),
				"hitbox_scale": 4,
				"image": "res://assets/sprites/sink.png",
				"image_complete": "res://assets/sprites/sink.png"
			}
		],
		"blockers": [
			{
				# bench
				"position": Vector2(750, 500),
				"hitbox_scale": 4
			},
			{
				# curtain
				"position": Vector2(450, 400),
				"hitbox_scale": 1
			},
			{
				# bed
				"position": Vector2(380, 440),
				"hitbox_scale": 4
			},
			{
				# sink back
				"position": Vector2(550, 350),
				"hitbox_scale": 1
			}
		],
		"image": "res://assets/sprites/room_1.png"
	},
	1: {
		"links": {
			3: 0,
			0: 2,
			1: 3
		},
		"interactions": [
			{
				# IV minigame
				"id": 0,
				"position": Vector2(750, 450),
				"image": "res://assets/sprites/iv.png",
				"image_complete": "res://assets/sprites/potatowithiv.png"
			}
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	2: {
		"links": {
			2: 1,
			1: 4
		},
		"interactions": [
			{
				# potoooooooo
				"id": 1,
				"position": Vector2(400, 450),
				"image": "res://assets/sprites/potato.png",
				"image_complete": ""
			}
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	3: {
		"links": {
			3: 1
		},
		"interactions": [
			{
				"id": 3,
				"position": Vector2(750, 450),
				"image": "res://icon.svg",
				"image_complete": ""
			}
		],
		"blockers": [
			{
				# block doppelganger
				"position": Vector2(440, 440),
				"hitbox_scale": 4,
				"image": "res://icon.svg"
			}
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	4: {
		"links": {
			0: 2
		},
		"interactions": [
			{
				# pills
				"id": 4,
				"position": Vector2(800, 450),
				"image": "res://assets/sprites/potato.png", # TODO Pill bottles on table in room
				"image_complete": "res://assets/sprites/potato.png" # TODO cleaned up pill bottles
			}
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	9: {
		"links": {
		},
		"interactions": [
			{
				# finale
				"id": 9,
				"position": Vector2(600, 350),
				"hitbox_scale": 4,
				"image": "res://assets/sprites/sink.png",
				"image_complete": "res://assets/sprites/sink.png"
			}
		],
		"blockers": [
			{
				# bench
				"position": Vector2(750, 500),
				"hitbox_scale": 4
			},
			{
				# curtain
				"position": Vector2(450, 400),
				"hitbox_scale": 1
			},
			{
				# bed
				"position": Vector2(380, 440),
				"hitbox_scale": 4
			},
			{
				# sink back
				"position": Vector2(550, 350),
				"hitbox_scale": 1
			}
		],
		"image": "res://assets/sprites/room_1.png"
	}
}


static func create_room(room_id: int, last_door_position: int):
	var data = room_data[room_id]
	var room = room_obj.instantiate()
	room.room_id = room_id
	room.image = data["image"]
	var new_door_position = (last_door_position + 2) % 4
	for link in data["links"]:
		room.create_link(
			link,
			door_positions[link],
			data["links"][link],
			last_door_position == -1 or link != new_door_position
		)
	for interaction in data.get("interactions", []):
		room.create_interaction(interaction)
	if room_id == 0 and GameState.are_tasks_complete():
		room.create_interaction(
			{
				# IV minigame
				"id": 8,
				"position": Vector2(750, 470),
				"image": "res://assets/sprites/Patient chart.png",
				"image_complete": ""
			})
	for blocker in data.get("blockers", []):
		room.create_blocker(blocker)
	var character = character_obj.instantiate()
	if last_door_position == -1:
		character.position = ROOM_CENTRE
	else:
		character.position = door_positions[new_door_position]
	room.add_child(character)
	room.character = character
	if room_id == 3:
		# spawn doppy
		var doppy = doppy_obj.instantiate()
		var opposite_door = {
			0: 1,
			1: 0,
			2: 3,
			3: 2
		}
		if last_door_position == -1:
			doppy.position = ROOM_CENTRE
		else:
			doppy.position = door_positions[opposite_door[new_door_position]]
		room.add_child(doppy)
	return room
