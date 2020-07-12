extends KinematicBody2D

var direction = Vector2.ZERO

export(int) var move_modifier = 300


func _input(event):
	if event is InputEventKey:
		if InputRandomizer.has_snapped(event.scancode):
			return
		
		if event.is_action_pressed("ren_up"):
			direction = Vector2.UP
		elif event.is_action_pressed("ren_down"):
			direction = Vector2.DOWN
		elif event.is_action_pressed("ren_left"):
			direction = Vector2.LEFT
		elif event.is_action_pressed("ren_right"):
			direction = Vector2.RIGHT
		elif event.is_action_pressed("ren_use"):
			pass # Use is to collect a Fix! block


func _physics_process(delta):
	if direction != Vector2.ZERO:
		move_and_slide(direction * move_modifier)
		direction = Vector2.ZERO
