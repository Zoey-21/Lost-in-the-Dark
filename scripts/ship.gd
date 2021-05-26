extends KinematicBody2D

onready var pickups = get_node("..").pickups

var speed = 200
var turn = 1
var move = 0
var rotate = 0
var start = false


func _ready():
	$ColorRect.visible = true

func _physics_process(delta):
	if pickups.size() > 0:
		$nodes.text = "Nodes Left to Collect: " + String(pickups.size())
	else:
		$nodes.text = "Follow the Sound to the Exit"
	if Input.is_action_just_pressed("darkness"):
		OS.window_fullscreen = !OS.window_fullscreen
	move = 0
	rotate = 0
	if start:
		if Input.is_action_pressed("rot_left"):
			rotate = -1
			if $turning/turn_Timer.is_stopped():
				$turning/turn_Timer.start()
		if Input.is_action_pressed("rot_right"):
			rotate = 1
			if $turning/turn_Timer.is_stopped():
				$turning/turn_Timer.start()
		if !Input.is_action_pressed("rot_left") and !Input.is_action_pressed("rot_right"):
			$turning.playing = false
		if Input.is_action_pressed("move_up"):
			move = -1
			if !$thrusters.playing:
				$thrusters.play()
		if Input.is_action_pressed("move_down"):
			move = 1
			if !$thrusters.playing:
				$thrusters.play()
		if !Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
			$thrusters.playing = false
	if move != 0:
		if !$thrusters.playing:
			$thrusters.play()
	if Input.is_action_pressed("run"):
		speed = 400
		$thrusters.pitch_scale = 1
	else:
		speed = 200
		$thrusters.pitch_scale = 0.7

	if $turning.playing and !Input.is_action_pressed("run"):
		$thrusters.playing = false
	rotation_degrees = rotation_degrees + (rotate * turn)
	move_and_slide(Vector2(0, move*speed).rotated(rotation))
	
	if Input.is_action_just_pressed("menu"):
		get_node("/root/global").voice_played = false
		get_tree().change_scene("res://main_menu.tscn")

var bullet = preload("res://player/echo_shot.tscn")# Loads shot to be fired
var bullet_speed = 500# speed for the bullet to move at

func _process(_delta): 
	if Input.is_action_just_pressed("shoot"): # if the player hit the shoot button
		var bullet_instance = bullet.instance() # set up a instance of the bullet
		bullet_instance.position = $bullet_spawn.get_global_position() #gives bullet player position
		bullet_instance.apply_central_impulse( Vector2(bullet_speed, 0).rotated(rotation+67.5)) #aplies force in direction aimed at
		get_tree().get_root().get_node("level").add_child(bullet_instance) # adds bullet to the root of the map
#		$"/root/Global".playerfire.play()#play the fireing sound


func _on_disable_moves_timeout():
	start = true


func _on_front_area_entered(area):
	if area.is_in_group("pickups"):
		area.behind = false


func _on_back_area_entered(area):
	if area.is_in_group("pickups"):
		area.behind = true


func _on_turn_Timer_timeout():
	$turning.play()



func _on_bump_body_entered(body):
	if !body.is_in_group("shot"):
		$bump/bump_sound.play()
