extends Control

var main_tscn = preload("res://Code/Main/main.tscn")

func _on_normal_b_pressed():
	start_game()


func _on_endless_b_pressed():
	#GameManager.mode("Endless")
	start_game()

func start_game():
	get_tree().change_scene_to_packed(main_tscn)
