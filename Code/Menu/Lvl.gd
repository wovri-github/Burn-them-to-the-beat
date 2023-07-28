extends Control

var main_tscn = preload("res://Code/Main/main.tscn")
#var main_tscn = preload("res://Code/Main/main.tscn")

func _ready():
	var activate_endless_mode = Storage.get_value("state", "activate_endless_mode", false)
	if activate_endless_mode == true:
		$VBoxContainer/Endless.disabled = false
	
func start_game(lvl_mode):
	var main_inst = main_tscn.instantiate()
	main_inst.set_mode(lvl_mode)
	get_tree().get_root().add_child(main_inst)
	queue_free()


func _on_normal_b_pressed():
	start_game(Defaluts.MODE.STORY)


func _on_endless_pressed():
	start_game(Defaluts.MODE.ENDLESS)
