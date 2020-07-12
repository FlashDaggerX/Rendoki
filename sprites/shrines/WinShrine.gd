extends "Shrine.gd"

export(PackedScene) var next_level


func _on_WinShrine_body_entered(body):
	InputRandomizer.event_fix_all()
	LevelSwitcher.switch_level(next_level)
