extends "Shrine.gd"


func _on_FixShrine_body_entered(body):
	InputRandomizer.event_fix()
	collider_free()
