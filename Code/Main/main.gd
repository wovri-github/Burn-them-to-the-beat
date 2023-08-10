extends Node

var end_screen_inst = preload("res://Code/Menu/EndScreen.tscn").instantiate()



func _ready():
	for node in self.get_children():
		node.game_over.connect(_on_game_over)


func _on_game_over(is_win):
	var game_result: GameResult = $Game.get_game_result()
	game_result.is_win = is_win
	
	for node in self.get_children():
		node.queue_free()
	
	end_screen_inst.set_game_result(game_result)
	add_child(end_screen_inst)
