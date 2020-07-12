extends Control

onready var _pausemenu = $Menu


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_pausemenu.popup()


func _on_Restart_pressed():
	LevelSwitcher.restart_current_level()
	hide()


func _on_Quit_pressed():
	get_tree().quit(0)
