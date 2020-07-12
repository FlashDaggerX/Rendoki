extends "Shrine.gd"


func _on_FixShrine_body_entered(body):
	InputRandomizer.add_fix()
	collider_free()
