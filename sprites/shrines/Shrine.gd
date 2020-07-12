extends Area2D

const MODULATOR = Color.black

export(bool) var free_on_collision = true


func _ready():
	if not free_on_collision:
		$ShrineAnimatedSprite.set_modulate(MODULATOR)


func collider_free():
	if free_on_collision:
		queue_free()
