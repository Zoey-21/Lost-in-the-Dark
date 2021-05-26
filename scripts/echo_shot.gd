extends RigidBody2D

onready var player = get_node("../ship")

func _on_echo_shot_body_entered(body):
	if !body.is_in_group("shot"):
		$CollisionShape2D.set_deferred("disabled",true)
		visible = false
		if body.name == "pickups" or body.name == "end":
			$pickup.play()
		else:
			$AudioStreamPlayer2D.play()


func _on_AudioStreamPlayer2D_finished():
	queue_free()
