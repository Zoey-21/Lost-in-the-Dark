extends Area2D




func _on_sound_timeout():
	$sound.play()


func _on_pickups_body_entered(body):
	if body.name == "ship":
		$collected.play()

func _on_collected_finished():
	queue_free()
