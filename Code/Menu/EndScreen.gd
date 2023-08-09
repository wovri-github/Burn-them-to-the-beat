extends CanvasLayer

var start_tscn = preload("res://Code/Menu/Start.tscn").instantiate()
var score = 0
var game_time = 0

@onready var score_label_value = $VBoxContainer/Score/Value
@onready var time_label_value = $VBoxContainer/Time/Value


func game_over(is_win):
	if is_win:
		$Title.text = "You win!"
	else:
		$Title.text = "You lose"

func _ready():
	var activate_endless_mode = Storage.get_value("state", "activate_endless_mode", false)
	if activate_endless_mode == true:
		$PlayEndless.disabled = false
	score_label_value.text = str(score)
	time_label_value.text = str(game_time)




func _on_menu_pressed():
	get_tree().get_root().add_child(start_tscn)
	queue_free()


func _on_play_endless_pressed():
	pass # Replace with function body.
