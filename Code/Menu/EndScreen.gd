extends CanvasLayer

var start_tscn = preload("res://Code/Menu/Start.tscn").instantiate()
var score = 0
var game_time = 0
@onready var score_label_value = $VBoxContainer/Score/Value
@onready var time_label_value = $VBoxContainer/Time/Value



func set_game_result(game_result: GameResult):
	score = game_result.score
	game_time = game_result.game_time
	game_over(game_result.is_win)

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
	GlobalVaribles.game_mode = Defaluts.MODE.ENDLESS
	get_tree().change_scene_to_file("res://Code/Main/main.tscn")
