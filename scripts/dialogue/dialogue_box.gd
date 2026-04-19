extends CanvasLayer

var text: RichTextLabel
@onready var text_panel: MarginContainer = $MarginContainer
@onready var text_box: NinePatchRect = $MarginContainer/NinePatchRect
@onready var shade_overlay = $shade_overlay


var dialogue_queue = []
var in_dialogue = false

func _on_queue_dialog(dialog_string_id):
	if not in_dialogue:
		start_displaying_dialog(dialog_string_id)
	else:
		dialogue_queue.append(dialog_string_id)

func _on_display_dialog(dialog_string_id):
	start_displaying_dialog(dialog_string_id)

func start_displaying_dialog(dialog_string_id):
	text_panel.visible = true
	text.visible = true
	shade_overlay.visible = true
	text.text = dialog_string_id
	GameState.freeze_inputs = true
	in_dialogue = true

func display_next_dialog():
	if not dialogue_queue.is_empty():
		start_displaying_dialog(dialogue_queue.pop_front())
	else:
		exit_dialogue()

func exit_dialogue():
	text.visible = false
	text_panel.visible = false
	shade_overlay.visible = false
	GameState.freeze_inputs = false
	in_dialogue = false

func _input(event):
	if in_dialogue and event.is_action_pressed("interact"):
		display_next_dialog()
		get_viewport().set_input_as_handled()

func _ready():
	text = find_child("dialog_display")
	EventBus.queue_dialog.connect(_on_queue_dialog)
	EventBus.display_dialog.connect(_on_display_dialog)
	EventBus.queue_dialog.emit("room0_string0")
	EventBus.queue_dialog.emit("room0_string1")
	EventBus.queue_dialog.emit("room0_string2")
