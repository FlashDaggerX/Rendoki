extends "res://sprites/shrines/WinShrine.gd"


func _on_LevelSwitcher_failed():
	get_node("../UI/Label").show()
	get_node("../UI/Quit").show()
