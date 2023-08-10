extends Node

var _disable_points = false
var score: int = 0
var _factor_sum: int

func _ready():
	GameEvents.new_factor_sum.connect(_on_new_factor_sum)

func points_logic(burned_humans_count):
	if _disable_points:
		return
	
	if burned_humans_count == 0:
		score -= 1 * _factor_sum
		if score <= 0:
			score = 0
	else:
		score += burned_humans_count * _factor_sum
	GameEvents.emit_signal("scored", score)

func _on_new_factor_sum(factor_sum):
	_factor_sum = factor_sum

func _on_fireing_humans_flamed(burned_humans_count: int):
	points_logic(burned_humans_count)
