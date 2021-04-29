extends KinematicBody2D

const wonder_speed = 200
const charge_speed = 1200

onready var nav = get_node("..")
onready var player = get_node("../ship")

onready var places_to_path = get_node("..").places_to_path
var nav_path = []
var charge_dir = Vector2()
var movement = Vector2()
var speed = 200
var screamed = false
var pathing = true



func _physics_process(delta):
	if pathing:
		pathing(delta)
	if $right.get_collider() != null:
		if $right.get_collider().name == "ship":
			if !screamed:
				charge()
				charge_dir = Vector2(1,0)
	if $left.get_collider() != null:
		if $left.get_collider().name == "ship":
			if !screamed:
				charge()
				charge_dir = Vector2(-1,0)
	if $up.get_collider() != null:
		if $up.get_collider().name == "ship":
			if !screamed:
				charge()
				charge_dir = Vector2(0,-1)
	if $down.get_collider() != null:
		if $down.get_collider().name == "ship":
			if !screamed:
				charge()
				charge_dir = Vector2(0,1)
	move_and_slide(movement*speed,Vector2(0, 0))

func pathing(delta):
	if Array(nav_path) == [] and places_to_path != []:
		var end_point = randi() % (places_to_path.size())
		nav_path = nav.get_simple_path(self.position, places_to_path[end_point].position)
	var distance_to_walk = speed * delta
	while distance_to_walk > 0 and nav_path.size() > 0:
		var distance_to_next_point = position.distance_to(nav_path[0])
		if distance_to_walk <= distance_to_next_point:
			position += position.direction_to(nav_path[0]) * distance_to_walk
		else:
			position = nav_path[0]
			nav_path.remove(0)
		distance_to_walk -= distance_to_next_point
	
func charge():
#	$CollisionShape2D.disabled = false
	$scream.play()
	pathing = false
	screamed = true
	movement = Vector2()
	speed = charge_speed

func _on_charge_timeout():
	$charge_disabled.start()
	$CollisionShape2D.disabled = true
	$collider/CollisionShape2D.disabled = true
	pathing = true
	movement = Vector2()
	speed = wonder_speed


func _on_scream_finished():
	$CollisionShape2D.disabled = false
	$collider/CollisionShape2D.disabled = false
	$charge.start()
	movement = charge_dir


func _on_collider_body_entered(body):
	if body.name == "ship":
		var death_sound = AudioStreamPlayer.new()
		death_sound.set_stream(load("res://sounds/death.wav"))
		get_tree().get_root().add_child(death_sound) 
		death_sound.play()
		get_tree().reload_current_scene()


func _on_charge_disabled_timeout():
	screamed = false
