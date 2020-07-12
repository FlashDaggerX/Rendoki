extends Panel

var idx = 0

onready var _content = $Content


func _on_Next_pressed():
	get_current_page().hide()
	next_page().show()


func _on_Prev_pressed():
	get_current_page().hide()
	prev_page().show()


func prev_page():
	if idx == 0:
		return get_current_page()
	
	idx -= 1
	return get_current_page()


func get_current_page():
	return _content.get_child(idx)


func next_page():
	if idx == _content.get_child_count() - 1:
		return get_current_page()
	
	idx += 1
	return get_current_page()
