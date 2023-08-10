extends Node2D

signal game_over(is_win)

var game_time = 0
var is_endless = false



func _ready():
	if GlobalVaribles.game_mode == Defaluts.MODE.ENDLESS:
		turn_on_endless_mode()

func get_game_result() -> GameResult:
	var game_result = GameResult.new()
	game_result.score = $ScoreCalculator.score
	game_result.game_time = game_time
	return game_result

func turn_on_endless_mode():
	is_endless = true
	$Story.queue_free()
	$FireingHumans.is_endless = true
	$HitGoblinManager.left_on = true
	$MusicBars.show_left_group()
	$HitGoblinManager.right_on = true
	$MusicBars.show_right_group()
	$HitGoblinManager.change_goblin_visibility(true)


func _on_sec_timer_timeout():
	game_time += 1
