extends Node

signal switched (old_key, new_key)
signal snapped (key)
signal fixed (key)
signal all_fixed
signal fix_count_changed

var fixes_remaining = 2
var snapped_keys = []

var audio
onready var INIT_ACTIONS = _get_available_actions()


func _ready():
	audio = AudioStreamPlayer2D.new()
	add_child(audio)

# Remaps the action according to the action list in $ControlStatus
func remap_action(action, key):
	var new_input = InputEventKey.new()
	new_input.set_scancode(key)
	
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, new_input)


func event_switch():
	var f_action = _randomize_action()
	# Index 0, since we only use keyboard controls for now.
	var old_key = _action_key(f_action)
	
	var t_action = _randomize_action()
	if t_action == f_action:
		t_action = INIT_ACTIONS[3]
	var new_key = _action_key(t_action)
	
	if has_snapped(new_key) or has_snapped(old_key):
		return
	
	# TODO: Switches the display, but not the keybinding
	remap_action(f_action, new_key)
	remap_action(t_action, old_key)
	
	_play_audio(AudioFile.SWITCH)
	emit_signal("switched", old_key, new_key)


func event_snap():
	var action = _randomize_action()
	var key = _action_key(action)
	
	if not has_snapped(key):
		snapped_keys.append(key)
		_play_audio(AudioFile.SNAP)
		emit_signal("snapped", key)


func event_fix():
	if len(snapped_keys) != 0:
		var key = snapped_keys.pop_back()
		remove_fix()
		_play_audio(AudioFile.FIX)
		emit_signal("fixed", key)


func event_fix_all():
	snapped_keys.clear()
	set_fixes(2)
	emit_signal("all_fixed")


func set_fixes(fix):
	fixes_remaining = fix
	emit_signal("fix_count_changed")


func add_fix():
	fixes_remaining += 1
	emit_signal("fix_count_changed")


func remove_fix():
	fixes_remaining -= 1
	emit_signal("fix_count_changed")


func get_remaining_fixes():
	return fixes_remaining


func has_snapped(key):
	return snapped_keys.has(key)


func _play_audio(file):
	audio.set_stream(file)
	audio.play()


func _randomize_action():
	var avail_actions = _get_available_actions()
	
	randomize()
	return avail_actions[randi() % len(avail_actions)]


func _action_key(action):
	return InputMap.get_action_list(action)[0].get_scancode()


func _get_available_actions():
	var actions = InputMap.get_actions()
	# Uses 13 as a constant, because there are 13 actions we can't delete...
	return actions.slice(13, len(actions))
