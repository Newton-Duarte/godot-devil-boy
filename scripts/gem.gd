extends Area2D


func _on_body_entered(body):
	$CollectSfx.play()
	Global.collect_gem()
	hide()

func _on_collect_sfx_finished():
	queue_free()
