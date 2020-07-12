extends Node

"""
Manages the level switching at the top level.
"""

# Emitted before the scene is switched, but after the last level is freed.
signal switching
signal failed

const MAIN_SCENE = preload("res://main/Main.tscn")

onready var _main = get_node("/root/Main")


func switch_level(scene):
	var last_level = _main.get_child(_main.get_child_count() - 1)
	
	if not scene:
		emit_signal("failed")
		return
	
	var new_level = scene.instance()
	
	last_level.queue_free()
	# Yield is used here to prevent bad scene states (Godot was complaining)
	yield(get_tree(), "tree_changed")
	
	emit_signal("switching")
	_main.add_child(new_level)


func restart_current_level():
	var level = _main.get_child(_main.get_child_count() - 1)
	
	if level.name == "Tutorial":
		return
	
	switch_level(load(level.filename))
	
