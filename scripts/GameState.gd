extends Node

static var task_completion = {
	0: false, #0 IV / potato
	1: false, #1 potato pickup
	2: false, #2 mirror
	4: false, #4 pills
	8: false, #8 chart
	9: false, #9 final mirror
}
# Tasks required for the chart to appear in room 0
static var required_tasks = [
	0, 1, 2, 3, 4
]
static var freeze_inputs = false
static var checked_mirror = 0
static var has_interacted = false
static var doppy_room_visited = 0

static func are_tasks_complete() -> bool:
	return true
	for task in required_tasks:
		if not task_completion[task]:
			return false
	return true
