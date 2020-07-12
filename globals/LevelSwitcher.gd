extends Node

"""
Manages the level switching at the top level.
"""

# Emitted before the scene is switched, but after the last level is freed.
signal switching
signal failed

const MAIN_SCENE = preload("res://main/Main.tscn")


func switch_level(scene):
	var last_level = get_main().get_child(get_main().get_child_count() - 1)
	
	if not scene:
		emit_signal("failed")
		return
	
	var new_level = scene.instance()
	
	last_level.queue_free()
	# Yield is used here to prevent bad scene states (Godot was complaining)
	yield(get_tree(), "tree_changed")
	
	emit_signal("switching")
	get_main().add_child(new_level)


func restart_current_level():
	var level = get_main().get_child(get_main().get_child_count() - 1)
	if level.name == "Tutorial":
		return
	var new_level = load(level.filename)
	
	get_tree().change_scene_to(MAIN_SCENE)
	InputRandomizer.event_fix_all()
	
	switch_level(new_level)
	

func get_main():
	return get_node("/root/Main")
