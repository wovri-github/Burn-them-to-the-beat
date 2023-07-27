extends Node

var intro_inst = preload("res://Code/Intro.tscn").instantiate()
var game_inst = preload("res://Code/Game/Game.tscn").instantiate()
var ux_inst = preload("res://Code/GUI/UX.tscn").instantiate()
var conductor_inst = preload("res://Code/Game/conductor.tscn").instantiate()
var end_screen_inst = preload("res://Code/Menu/EndScreen.tscn").instantiate()
var is_in_game = false



func _ready():
	play_intro()

func _unhandled_input(event):
	if not is_in_game and event.is_action("ui_accept"):
		is_in_game = true
		play_game()

func play_intro(): 
	add_child(intro_inst)


func set_mode(lvl_mode):
	match lvl_mode:
		Defaluts.MODE.STORY:
			pass
		Defaluts.LVL.HARD:
			$Game/HitGoblinManager.queue_free()
			$Game/Story.queue_free()

func play_game():
	intro_inst.queue_free()
	
	conductor_inst.game_over.connect(_on_game_over)
	game_inst.game_over.connect(_on_game_over)
	ux_inst.game_over.connect(_on_game_over)
	
	add_child(game_inst)
	add_child(ux_inst)
	add_child(conductor_inst)

func _on_game_over(is_win):
	var score = game_inst.score
	var game_time = game_inst.game_time
	game_inst.queue_free()
	ux_inst.queue_free()
	conductor_inst.queue_free()
	
	end_screen_inst.score = score
	end_screen_inst.game_time = game_time
	end_screen_inst.game_over(is_win)
	add_child(end_screen_inst)
