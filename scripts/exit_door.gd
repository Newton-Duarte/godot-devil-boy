extends Area2D

@export var next_level := ""

@onready var sfx = $SFX
@onready var timer = $Timer

func _on_body_entered(body):
	if timer.is_stopped():
		sfx.play()
		timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file(next_level)
