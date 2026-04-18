extends CanvasLayer

@onready var text_label: RichTextLabel = $RichTextLabel

func starting_dialogue():
	var read_dialogue = false
	var dialogue_loop = {
		line0 = "room0_string0",
		line1 = "room0_string1"
	}

	if not read_dialogue:
		for line in dialogue_loop.values():
			text_label.text = line
			await get_tree().create_timer(2.0).timeout
		read_dialogue = true

func _ready():
	starting_dialogue()
