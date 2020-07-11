extends Node

signal remapped (old_key, new_key)


# Remaps the action according to the action list in $ControlStatus
func remap_action(action, key):
	# Index 0, since we only use keyboard controls for now.
	var old_key = get_current_action_map(action)[0].get_scancode()
	
	var new_input = InputEventKey.new()
	new_input.set_scancode(key)
	
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, new_input)
	emit_signal("remapped", old_key, key)


func get_current_action_map(action):
	return InputMap.get_action_list(action)
