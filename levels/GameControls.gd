extends VBoxContainer

# In the order of $ControlStatus/Icons
enum {A_ESC, A_W, A_S, A_A, A_D}

onready var _actui = $ControlStatus/Actions


func _ready():
	move_ui_header(A_ESC, A_A)


# Remaps the action according to the action list in $ControlStatus
func remap_action(action, key):
	InputMap.action_erase_events(action)
	
	var new_input = InputEventKey.new()
	new_input.set_scancode(key)
	
	InputMap.action_add_event(action, new_input)


# Moves the action label from f_key to t_key
func move_ui_header(f_key, t_key):
	_actui.move_child(_actui.get_child(f_key), t_key)
