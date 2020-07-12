extends Node2D

export(int) var allowed_fixes = 2


func _ready():
	InputRandomizer.set_fixes(allowed_fixes)
