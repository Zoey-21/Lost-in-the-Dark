extends Node2D

var level_to_load 

func _input(event):
	match event.as_text():
		"1":
			level_select("res://levels/level_1.tscn",1)
		"2":
			level_select("res://levels/level_2.tscn",2)
		"3":
			level_select("res://levels/level_3.tscn",3)
		"4":
			level_select("res://levels/level_4.tscn",4)
		"5":
			level_select("res://levels/level_5.tscn",5)
		"6":
			level_select("res://levels/level_6.tscn",6)
		"7":
			level_select("res://levels/level_7.tscn",7)
		"8":
			level_select("res://levels/level_8.tscn",8)
		"9":
			level_select("res://levels/level_9.tscn",9)
		"Enter":
			if level_to_load != null:
				get_tree().change_scene(level_to_load)

func level_select(level, text):
	$ColorRect/Label.text = "Level " + String(text)
	level_to_load = level
