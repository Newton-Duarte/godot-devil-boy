extends Area2D

@onready var timer = $Timer
@onready var sfx = $SFX


func _on_body_entered(body):
	print("You died")
	sfx.play()
	body.velocity.y = -300
	body.get_node("AnimatedSprite2D").flip_v = true
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout():
	Global.lose_life()
