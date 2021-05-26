extends Area2D

var behind = false
var playback_sec
var sound_offset

func _ready():
	sound_offset = rand_range(0,1.5)
	$sound_play.wait_time = $sound_play.wait_time + sound_offset
func _physics_process(delta):
	if $sound.playing and behind:
		playback_sec = $sound.get_playback_position()
		$sound.playing = false
		$sound_behind.play(playback_sec)
	if $sound_behind.playing and !behind:
		playback_sec = $sound_behind.get_playback_position()
		$sound_behind.playing = false
		$sound.play(playback_sec)

func _on_sound_timeout():
	if behind:
		$sound_behind.play()
	else:
		$sound.play()


func _on_pickups_body_entered(body):
	if body.name == "ship":
		$collected.play()

func _on_collected_finished():
	queue_free()
