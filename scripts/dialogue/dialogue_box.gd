extends CanvasLayer

@onready var text_label: RichTextLabel = $RichTextLabel

func starting_dialogue():
	text_label.visible = true
	var read_dialogue = false
	var dialogue_loop = {
		line0 = "[wave amp=50.0 freq=5.0 connected=1]room0_string0[/wave]",
		line1 = "room0_string1"
	}

	if not read_dialogue:
		for line in dialogue_loop.values():
			text_label.text = line
			await get_tree().create_timer(2.0).timeout
		read_dialogue = true
		text_label.visible = false

func _ready():
	starting_dialogue()
