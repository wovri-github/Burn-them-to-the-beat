extends Node

var intro_inst = preload("res://Code/Intro.tscn").instantiate()
var game_inst = preload("res://Code/Game/Game.tscn").instantiate()
var ux_inst = preload("res://Code/GUI/UX.tscn").instantiate()
var conductor_inst = preload("res://Code/Game/conductor.tscn").instantiate()
var is_in_game = false



func _ready():
	play_intro()

func _unhandled_input(event):
	if not is_in_game and event.is_action("ui_accept"):
		is_in_game = true
		play_game()

func play_intro():
	add_child(intro_inst)

func play_game():
	intro_inst.queue_free()
	add_child(game_inst)
	add_child(ux_inst)
	add_child(conductor_inst)


func set_mode(lvl_mode):
	match lvl_mode:
		Defaluts.MODE.STORY:
			pass
		Defaluts.LVL.HARD:
			$Game/HitGoblinManager.queue_free()
			$Game/Story.queue_free()

