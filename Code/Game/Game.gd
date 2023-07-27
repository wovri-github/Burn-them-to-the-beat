extends Node2D

signal game_over(is_win)

const PROGRESS_FACTOR_DEPRECIATION = 75
const SPACE_ALLOWANCE_MSEC = 100
const BEAT_TIME_MSEC = 571
const MAX_HP = Defaluts.MAX_HP
@export var _runtime_data: RuntimeData
var _current_number_pool: Array
var _correct_number: int
var _current_left_number: int
var _current_right_number: int
var _factor_sum: int = 1:
	set(val):
		_factor_sum = val
		GameEvents.emit_signal("new_factor_sum", val)
var _disable_points = false
var _beat_multiplier: int = 0
var score = 0
var game_time = 0
var is_endless = false
var hp = Defaluts.STARTING_HP




func _ready():
	GameEvents.emit_signal("new_factor_sum", _factor_sum)
	GameEvents.new_boxes_number_picked.connect(_on_new_boxes_number_picked)
	GameEvents.new_pool_picked.connect(_on_new_pool_picked)
	GameEvents.hit_made.connect(_on_hit_made)




func _process(delta):
	var _factor_progress = _runtime_data.factor_progress
	_factor_progress -= delta * 10
	if _factor_progress < 0:
		if _factor_sum > 1:
			_factor_sum -= 1
			_factor_progress += 100
		else:
			_factor_progress = 0
	_runtime_data.factor_progress = _factor_progress

func factor_logic(is_correct):
	var _factor_progress = _runtime_data.factor_progress
	if is_correct:
		_factor_progress += 20
		if _factor_progress >= 100:
			if _factor_sum <= 10:
				_factor_progress = 15
				_factor_sum += 1
			else:
				_factor_progress = 100
	elif _factor_sum > 1 or _factor_progress > PROGRESS_FACTOR_DEPRECIATION:
		_factor_progress -= PROGRESS_FACTOR_DEPRECIATION
	_runtime_data.factor_progress = _factor_progress



func _on_new_pool_picked(new_pool):
	_current_number_pool = new_pool
	_correct_number = new_pool[0]

func _on_new_boxes_number_picked(left: int, right: int):
	_current_left_number = left
	_current_right_number = right


func points_logic(_is_human_burned):
	if _disable_points:
		return
	if _is_human_burned:
		score += 1 * _factor_sum
	else:
		score -= 1 * _factor_sum
		if score <= 0:
			score = 0
	GameEvents.emit_signal("scored", score)

func lose_hp():
	hp -= 1
	if hp <= 0:
		hp = 0
		emit_signal("game_over", false)
	GameEvents.emit_signal("hp_changed", hp)

func turn_on_endless_mode():
	is_endless = true
	$HitGoblinManager.left_on = true
	$MusicBars.show_left_group()
	$HitGoblinManager.right_on = true
	$MusicBars.show_right_group()
	$HitGoblinManager.change_goblin_visibility(true)
	
	
	


func _on_fireing_humans_flamed(_is_human_burned):
	points_logic(_is_human_burned)

func _on_fireing_humans_human_escaped():
	lose_hp()

func _on_hit_made(is_correct, is_left_side):
	factor_logic(is_correct)


func _on_story_show_left_side():
	$HitGoblinManager.left_on = true
	$MusicBars.show_left_group()


func _on_sec_timer_timeout():
	game_time += 1
