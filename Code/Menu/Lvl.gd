extends Control

var main_tscn = preload("res://Code/Main/main.tscn")

func start_game(lvl_mode):
	var main_inst = main_tscn.instantiate()
	main_inst.init(lvl_mode)
	get_tree().get_root().add_child(main_inst)
	#get_tree().change_scene_to_packed(main_tscn)
	queue_free()


func _on_normal_b_pressed():
	start_game(Defaluts.MODE.STORY)


func _on_hard_b_pressed():
	start_game(Defaluts.LVL.HARD)


func _on_extreme_b_pressed():
	start_game(Defaluts.LVL.EXTREME)
