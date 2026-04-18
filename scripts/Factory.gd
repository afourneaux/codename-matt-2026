class_name Factory
extends Object


static var room_obj = preload("res://scenes/rooms/room.tscn")
static var character_obj = preload("res://scenes/player/player_character.tscn")
const ROOM_CENTRE = Vector2(576,400)

static var door_positions = {
	0: Vector2(450, 420),
	1: Vector2(700, 400),
	2: Vector2(700, 520),
	3: Vector2(450, 520)
}

static var room_data = {
	# Room 0 - beginning / end room
	0: {
		"links": {
			2: 1
		},
		"interactions": [
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	1: {
		"links": {
			0: 0,
			1: 2,
			2: 3
		},
		"interactions": [
			{
				"id": 0,
				"posx": 576,
				"posy": 350
			}
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	2: {
		"links": {
			3: 1,
			2: 4
		},
		"interactions": [
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	3: {
		"links": {
			0: 1,
			1: 4
		},
		"interactions": [
		],
		"image": "res://assets/sprites/Room_Shape.png"
	},
	4: {
		"links": {
			3: 3,
			0: 2
		},
		"interactions": [
		],
		"image": "res://assets/sprites/Room_Shape.png"
	}
}


static func create_room(room_id: int, last_door_position: int):
	var data = room_data[room_id]
	var room = room_obj.instantiate()
	room.room_id = room_id
	room.image = data["image"]
	var new_door_position = (last_door_position + 2) % 4
	for link in data["links"]:
		room.create_link(link, door_positions[link], data["links"][link], link != new_door_position)
	for interaction in data["interactions"]:
		room.create_interaction(interaction["posx"], interaction["posy"], interaction["id"])
	var character = character_obj.instantiate()
	if last_door_position == -1:
		character.position = ROOM_CENTRE
	else:
		character.position = door_positions[new_door_position]
	room.add_child(character)
	room.character = character
	return room
