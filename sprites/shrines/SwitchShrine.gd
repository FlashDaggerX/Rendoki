extends "Shrine.gd"


func _on_SwitchShrine_body_entered(body):
	InputRandomizer.event_switch()
	collider_free()
