extends Control



func _on_start_b_pressed():
	get_tree().change_scene_to_file("res://Code/Menu/Lvl.tscn")
	queue_free()


func _on_quit_b_pressed():
	get_tree().quit()


func _on_credits_b_pressed():
	$Credits.show()
