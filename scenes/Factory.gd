class_name Factory
extends Object


static var room_obj = preload("res://scenes/rooms/room.tscn")

static var room_data = {
	# Room 0 - beginning / end room
	0: {
		"links": [
			{
				"pos": 2,
				"target": 1
			}
		],
		"interactions": [
			{
				"id": 0,
				"posx": 5,
				"posy": 10
			}
		],
		"image": "res://icon.svg"
	},
	1: {
		"links": [
			{
				"position": 0,
				"target": 0
			}
		],
	}
}


static func create_room(room_id: int):
	var data = room_data[room_id]
	var room = room_obj.instantiate()
	room.room_id = room_id
	room.image = data["image"]
	for link in data["links"]:
		room.create_link(link["pos"], link["target"])
	for interaction in data["interactions"]:
		room.create_interaction(interaction["posx"], interaction["posy"], interaction["id"])
	return room
