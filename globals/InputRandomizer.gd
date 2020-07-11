extends Node

signal switch (old_key, new_key)
signal snap (key)
signal fix (key)


# Remaps the action according to the action list in $ControlStatus
func remap_action(action, key):
	var new_input = InputEventKey.new()
	new_input.set_scancode(key)
	
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, new_input)


func event_switch():
	var avail_actions = []
	if true: # New body for slicing actions into avail_actions
		var actions = InputMap.get_actions()
		# Uses 13 as a constant, because there are 13 actions we can't delete...
		avail_actions = actions.slice(13, len(actions))
	
	randomize()
	var f_action = avail_actions[randi() % len(avail_actions)]
	# Index 0, since we only use keyboard controls for now.
	var old_key = InputMap.get_action_list(f_action)[0].get_scancode()
	
	randomize()
	var t_action = avail_actions[randi() % len(avail_actions)]
	if t_action == f_action:
		t_action = avail_actions[0]
	var new_key = InputMap.get_action_list(t_action)[0].get_scancode()
	
	# TODO: Switches the display, but not the keybinding
	print(f_action, new_key)
	print(t_action, old_key)
	remap_action(f_action, new_key)
	remap_action(t_action, old_key)
	
	emit_signal("switch", old_key, new_key)


func event_snap():
	pass


func event_fix():
	pass


func has_snapped(action):
	return not InputMap.has_action(action)
