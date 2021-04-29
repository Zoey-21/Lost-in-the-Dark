extends RigidBody2D

onready var player = get_node("../ship")

func _on_echo_shot_body_entered(body):
#	var dis_from_player = sqrt(pow(player.position.x-position.x,2)+pow(player.position.y-position.y,2))/27
#	print(dis_from_player)
	$CollisionShape2D.set_deferred("disabled",true)
	visible = false
	if body.name == "pickups" or body.name == "end":
		$pickup.play()
	else:
		$AudioStreamPlayer2D.play()


func _on_AudioStreamPlayer2D_finished():
	queue_free()
