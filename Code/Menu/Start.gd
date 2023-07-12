extends Control



func _on_start_b_pressed():
	get_tree().change_scene_to_file("res://Code/Menu/Lvl.tscn")


func _on_quit_b_pressed():
	get_tree().quit()
