extends Timer

export(float) var tick_switch_chance


func _on_SwitchTimer_timeout():
	randomize()
	if randf() < tick_switch_chance:
		InputRandomizer.event_switch()
