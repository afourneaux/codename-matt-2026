extends Node

static var task_completion = {
	0: false, #0 IV / potato
	1: false, #1 potato pickup
	2: false, #2 mirror
	3: false, #3 key
	4: false, #4 pills
	5: false, #5 bandage
	8: false, #8 chart
	9: false, #9 final mirror
}
# Tasks required for the chart to appear in room 0
static var required_tasks = [
	0, 1, 2, 3, 4
]
static var in_minigame = false
static var in_dialogue = false
static var checked_mirror = 0
static var has_interacted = false
static var doppy_room_visited = 0
static var potato_alone_room_visited = 0
static var current_room_id = 0

static func are_tasks_complete() -> bool:
	for task in required_tasks:
		if not task_completion[task]:
			return false
	return true

static func freeze_inputs() -> bool:
	return in_minigame or in_dialogue

static func is_endgame():
	return task_completion[8]
