extends CanvasLayer

@onready var text: RichTextLabel = $MarginContainer/NinePatchRect/RichTextLabel
@onready var text_panel: MarginContainer = $MarginContainer
@onready var text_box: NinePatchRect = $MarginContainer/NinePatchRect

func starting_dialogue():
	text_panel.visible = true
	text.visible = true
	var read_dialogue = false
	var dialogue_loop = {
		line0 = "room0_string0",
		line1 = "room0_string1"
	}

	if not read_dialogue:
		for line in dialogue_loop.values():
			text.text = line
			await get_tree().create_timer(2.0).timeout
		read_dialogue = true
		text.visible = false
		text_panel.visible = false

func _ready():
	starting_dialogue()
