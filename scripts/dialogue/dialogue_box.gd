extends CanvasLayer

@onready var text: RichTextLabel = $MarginContainer/NinePatchRect/RichTextLabel
@onready var text_panel: MarginContainer = $MarginContainer
@onready var text_box: NinePatchRect = $MarginContainer/NinePatchRect


var dialogue_queue = []
var display_dialog_timer

func _on_queue_dialog(dialog_string_id):
	if display_dialog_timer.is_stopped():
		start_displaying_dialog(dialog_string_id)
	else:
		dialogue_queue.append(dialog_string_id)

func _on_display_dialog(dialog_string_id):
	start_displaying_dialog(dialog_string_id)

func start_displaying_dialog(dialog_string_id):
	text_panel.visible = true
	text.visible = true
	text.text = dialog_string_id
	display_dialog_timer.start()

func display_next_dialog():
	text.visible = false
	text_panel.visible = false

	if not dialogue_queue.is_empty():
		start_displaying_dialog(dialogue_queue.pop_front())

func _ready():
	display_dialog_timer = Timer.new()
	display_dialog_timer.autostart = false
	display_dialog_timer.one_shot = true
	display_dialog_timer.wait_time = 3.0
	display_dialog_timer.timeout.connect(display_next_dialog)
	add_child(display_dialog_timer)
	EventBus.queue_dialog.connect(_on_queue_dialog)
	EventBus.display_dialog.connect(_on_display_dialog)
	EventBus.queue_dialog.emit("room0_string0")
	EventBus.queue_dialog.emit("room0_string1")
