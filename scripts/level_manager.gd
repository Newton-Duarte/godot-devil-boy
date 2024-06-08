extends Node2D

@export var current_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_level(current_level)
	print("Level 1 Ready")
