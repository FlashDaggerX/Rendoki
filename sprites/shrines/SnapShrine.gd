extends "Shrine.gd"


func _on_SnapShrine_body_entered(body):
	InputRandomizer.event_snap()
	collider_free()
