extends Control

var intro_tscn = preload("res://Code/Cutscenes/Intro.tscn")
var main_tscn = preload("res://Code/Main/main.tscn")



func _ready():
	var activate_endless_mode = Storage.get_value("state", "activate_endless_mode", false)
	if activate_endless_mode == true:
		$VBoxContainer/Endless.disabled = false


func _on_normal_b_pressed():
	GlobalVaribles.game_mode = Defaluts.MODE.STORY
	get_tree().change_scene_to_packed(intro_tscn)


func _on_endless_pressed():
	GlobalVaribles.game_mode = Defaluts.MODE.ENDLESS
	get_tree().change_scene_to_packed(main_tscn)
