extends VBoxContainer

# In the order of $ControlStatus/Icons
enum {A_ESC, A_W, A_S, A_A, A_D, A_E}

onready var _actic = $ControlStatus/Icons
onready var _actui = $ControlStatus/Actions


func _ready():
	InputRandomizer.connect("switch", self, "_on_input_switch")


func _on_input_switch(old_key, new_key):
	old_key = translate_key(old_key)
	new_key = translate_key(new_key)
	
	change_text_switch(old_key, new_key)
	move_ui_header(old_key, new_key)
	
	return_text(old_key)
	return_text(new_key)


# Moves the action label from f_key to t_key
func move_ui_header(f_key, t_key):
	# move_child() doesn't preserve any keys it hasn't touched.
	#_actui.move_child(_actui.get_child(f_key), t_key)
	var f_node = _actui.get_child(f_key)
	var t_node = _actui.get_child(t_key)
	
	var t_text = t_node.get_text()
	t_node.set_text(f_node.get_text())
	f_node.set_text(t_text)


func change_text_snap(key):
	_actic.get_child(key).set_texture(KeyTextures.TXT_SNAP)


func change_text_switch(f_key, t_key):
	_actic.get_child(f_key).set_texture(KeyTextures.TXT_SWITCH)
	_actic.get_child(t_key).set_texture(KeyTextures.TXT_SWITCH)


func change_text_fix(key):
	_actic.get_child(key).set_texture(KeyTextures.TXT_FIX)


func return_text(key):
	match key:
		A_W: _actic.get_child(A_W).set_texture(KeyTextures.TXT_W)
		A_S: _actic.get_child(A_S).set_texture(KeyTextures.TXT_S)
		A_A: _actic.get_child(A_A).set_texture(KeyTextures.TXT_A)
		A_D: _actic.get_child(A_D).set_texture(KeyTextures.TXT_D)
		A_E: _actic.get_child(A_E).set_texture(KeyTextures.TXT_E)
		A_ESC: return _actic.get_child(A_ESC).set_texture(KeyTextures.TXT_ESC)


func translate_key(key):
	match key:
		KEY_W: return A_W
		KEY_S: return A_S
		KEY_A: return A_A
		KEY_D: return A_D
		KEY_E: return A_E
		KEY_ESCAPE: return A_ESC
		_: return -1
