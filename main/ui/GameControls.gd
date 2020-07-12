extends Control

# In the order of $ControlStatus/Icons
enum {A_ESC, A_E, A_W, A_S, A_A, A_D}

onready var _actic = $ControlStatus/Icons
onready var _actui = $ControlStatus/Actions
onready var _fixct = $Fixes


func _ready():
	InputRandomizer.connect("switched", self, "_on_InputRandomizer_switched")
	InputRandomizer.connect("snapped", self, "_on_InputRandomizer_snapped")
	InputRandomizer.connect("fixed", self, "_on_InputRandomizer_fixed")
	InputRandomizer.connect("all_fixed", self, "_on_InputRandomizer_all_fixed")
	InputRandomizer.connect("fix_count_changed", self, "_on_InputRandomizer_fix_count_changed")


func _on_InputRandomizer_switched(old_key, new_key):
	old_key = _translate_key(old_key)
	new_key = _translate_key(new_key)
	
	change_text_switch(old_key, new_key)
	move_ui_header(old_key, new_key)
	
	change_text_normal(old_key)
	change_text_normal(new_key)


func _on_InputRandomizer_snapped(key):
	key = _translate_key(key)
	
	change_text_snap(key)


func _on_InputRandomizer_fixed(key):
	key = _translate_key(key)
	
	change_text_normal(key)


func _on_InputRandomizer_all_fixed():
	# Six for six keys
	for key in range(6):
		change_text_normal(key)


func _on_InputRandomizer_fix_count_changed():
	_fixct.set_text("Fix! Uses: " + str(InputRandomizer.get_remaining_fixes()))


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
	var node = _actic.get_child(key)
	node.set_texture(KeyTextures.TXT_SNAP)
	node.set_modulate(KeyTextures.MOD_SNAP)
	


func change_text_switch(f_key, t_key):
	_actic.get_child(f_key).set_texture(KeyTextures.TXT_SWITCH)
	_actic.get_child(t_key).set_texture(KeyTextures.TXT_SWITCH)


func change_text_fix(key):
	_actic.get_child(key).set_texture(KeyTextures.TXT_FIX)


func change_text_normal(key):
	var node
	var texture
	
	match key:
		A_W: 
			node = _actic.get_child(A_W)
			texture = KeyTextures.TXT_W
		A_S: 
			node = _actic.get_child(A_S)
			texture = KeyTextures.TXT_S
		A_A: 
			node = _actic.get_child(A_A)
			texture = KeyTextures.TXT_A
		A_D: 
			node = _actic.get_child(A_D)
			texture = KeyTextures.TXT_D
		_: return
	
	node.set_texture(texture)
	node.set_modulate(KeyTextures.MOD_NORM)


func _translate_key(key):
	match key:
		KEY_W: return A_W
		KEY_S: return A_S
		KEY_A: return A_A
		KEY_D: return A_D
		KEY_E: return A_E
		KEY_ESCAPE: return A_ESC
		_: return -1
