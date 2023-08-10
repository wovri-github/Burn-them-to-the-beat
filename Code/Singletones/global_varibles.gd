extends Node

var game_mode: Defaluts.MODE:
	set(new_game_mode):
		if new_game_mode is Defaluts.MODE:
			game_mode = new_game_mode
		else:
			print("Bad mode used")
