class_name Factory
extends Object


static var room_obj = preload("res://scenes/rooms/room.tscn")
static var character_obj = preload("res://scenes/player/player_character.tscn")
const ROOM_CENTRE = Vector2(576,450)

static var door_positions = {
	0: Vector2(450, 400),
	1: Vector2(700, 400),
	2: Vector2(700, 500),
	3: Vector2(450, 500)
}

static var room_data = {
	# Room 0 - beginning / end room
	0: {
		"links": {
			2: 1
		},
		"interactions": [
			{
				"id": 0,
				"posx": 5,
				"posy": 10
			}
		],
		"image": "res://assets/sprites/Roomshape.png"
	},
	1: {
		"links": {
			0: 0
		},
		"interactions": [
		],
		"image": "res://icon.svg"
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
	return room
