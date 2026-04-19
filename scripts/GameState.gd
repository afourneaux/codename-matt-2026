extends Node

#0 IV / potato
#1 potato pickup
#2 mirror
#3 chart
#4 final mirror
const TOTAL_INTERACTIBLES = 3
static var task_completion = []
static var in_mini_game = false
static var checked_mirror = 0

func _ready():
	for i in range(TOTAL_INTERACTIBLES):
		task_completion.append(false)
