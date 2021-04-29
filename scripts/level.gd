extends Navigation2D

var places_to_path = []
var pickups = []

func _physics_process(delta):
	for i in get_child_count():
		if get_child(i).get_filename() == "res://level_parts/pickups.tscn":
			if pickups.find(get_child(i)) == -1:
				pickups.append(get_child(i))
		if get_child(i).get_filename() == "res://level_parts/pickups.tscn" or get_child(i).get_filename() == "res://level_parts/wonder_points.tscn":
			if places_to_path.find(get_child(i)) == -1:
				places_to_path.append(get_child(i))
	for i in places_to_path:
		if !is_instance_valid(i):
			places_to_path.remove(places_to_path.find(i))
	for i in pickups:
		if !is_instance_valid(i):
			pickups.remove(pickups.find(i))
			
	if !get_node("/root/global").voice_played and $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()


func _on_AudioStreamPlayer_finished():
	get_node("/root/global").voice_played =true
