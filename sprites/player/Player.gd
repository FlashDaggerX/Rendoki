extends KinematicBody2D

var direction = Vector2.ZERO

onready var _mma = $MovementAnimator

export(int) var move_modifier = 50
export(float) var move_time = .15


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
		elif event.is_action_pressed("ui_focus_next"):
			if InputRandomizer.get_remaining_fixes() > 0:
				InputRandomizer.event_fix()


func _physics_process(delta):
	if direction != Vector2.ZERO:
		var dscale = $Sprite.scale
		_mma.interpolate_property($Sprite, "scale", 
				null, dscale / 2, 
				move_time, Tween.TRANS_QUAD)
		_mma.interpolate_method(self, "move_and_slide", 
				direction, direction * move_modifier, 
				move_time, Tween.TRANS_QUAD)
		_mma.interpolate_property($Sprite, "scale", 
				null, dscale, 
				move_time, Tween.TRANS_QUAD)
		_mma.start()
		direction = Vector2.ZERO
