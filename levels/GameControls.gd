extends VBoxContainer

# In the order of $ControlStatus/Icons
enum {A_ESC, A_W, A_S, A_A, A_D}

onready var _actui = $ControlStatus/Actions


func _ready():
	InputRandomizer.connect("remapped", self, "_on_key_remap")
	InputRandomizer.remap_action("ren_up", KEY_ESCAPE)


func _on_key_remap(old_key, new_key):
	move_ui_header(translate_key(old_key), translate_key(new_key))


# Moves the action label from f_key to t_key
func move_ui_header(f_key, t_key):
	_actui.move_child(_actui.get_child(f_key), t_key)


func translate_key(key):
	match key:
		KEY_W: return A_W
		KEY_S: return A_S
		KEY_A: return A_A
		KEY_D: return A_D
		KEY_ESCAPE: return A_ESC
		_: return -1
