extends Node

var tracked_nodes = {}
var audio_ids = 0
var bg_node
var bg_music
var muted = false

func _enter_tree():
	bg_node = AudioStreamPlayer.new()
	bg_node.name = "BGMusicPlayer"
	add_child(bg_node)

func _process(delta):
	for node in tracked_nodes:
		if !tracked_nodes[node].node.is_playing():
			if tracked_nodes[node].looping:
				tracked_nodes[node].node.play()
			else:
				stop_sfx(node)
	if bg_music and !bg_node.is_playing() and !muted:
		bg_node.play()

func play_bg_music(value):
	var new_music = load("res://assets/audio/%s.wav" % value)
	if bg_music != new_music:
		bg_music = new_music
		if bg_music == null:
			bg_node.stop()
		else:
			bg_node.stream = bg_music

func play_sfx(audio, loop=false, volume=1.0):
	var audio_resource = load("res://assets/audio/%s.wav" % audio)
	if audio_resource == null:
		push_error("Audio::play_sfx - Resource not found: %s" % audio)
		return
	var audio_node = AudioStreamPlayer.new()
	add_child(audio_node)
	audio_node.stream = audio_resource
	audio_node.volume_db = linear_to_db(volume)
	if not muted:
		audio_node.play()
	audio_ids = audio_ids + 1
	tracked_nodes[audio_ids] = {
		"node": audio_node,
		"looping": loop
	}
	return audio_ids

func stop_sfx(audio_id):
	tracked_nodes[audio_id].node.queue_free()
	tracked_nodes.erase(audio_id)

func mute():
	muted = true
	for node in tracked_nodes:
		stop_sfx(node)
	bg_node.stop()

func unmute():
	muted = false
