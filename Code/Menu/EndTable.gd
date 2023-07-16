extends Control

@onready var score_val_label = $Panel/VBoxContainer/Score/Value
@onready var time_val_label = $Panel/VBoxContainer/Time/Value
@onready var die_sound = $Die



func _ready():
	die_sound.play()
	score_val_label.text =  str(GameManager.score)
	time_val_label.text = str(GlobalTimer.game_time)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Code/Menu/Start.tscn")
