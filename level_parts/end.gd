extends Area2D

onready var global = get_node("/root/global")
onready var pickups = get_node("..").pickups
var started = false

func _ready():
	visible = false

func _physics_process(delta):
	if pickups == [] and !started:
		started = true
		$Timer.start()
		visible = true
		$sound.play()
		$CollisionShape2D.disabled = false
		$end/CollisionShape2D.disabled = false

func _on_Timer_timeout():
	$sound.play()


func _on_end_body_entered(body):
	if body.name == "ship":
		global.voice_played = false
		var next_level = global.levels.find(get_node("..").get_filename()) +1
		get_tree().change_scene(global.levels[next_level])
