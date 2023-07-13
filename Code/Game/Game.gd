extends Node2D

const PROGRESS_FACTOR_DEPRECIATION = 75
const SPACE_ALLOWANCE_MSEC = 100
const BEAT_TIME_MSEC = 571
const MAX_HP = Defaluts.MAX_HP
@export var _runtime_data: RuntimeData
var _current_number_pool: Array
var _correct_number: int
var _current_left_number: int
var _current_right_number: int
var _factor_total: int:
	set(val):
		_factor_total = val
		GameEvents.emit_signal("factor_total_changed", val)
var _disable_points = false
var _beat_multiplier: int = 0
var score = 0
var hp = Defaluts.STARTING_HP
@onready var fireing_humans = $FireingHumans



func _ready():
	GameEvents.new_boxes_number_picked.connect(_on_new_boxes_number_picked)
	GameEvents.new_pool_picked.connect(_on_new_pool_picked)
	GameEvents.beat.connect(_on_beat)
	GameEvents.setted_beat_multiplier.connect(_on_setted_beat_multiplier)

func _input(event):
	if event.is_action_pressed("ui_left") and _factor_total > 0:
		shake()
	if event.is_action_pressed("ui_right") and _factor_total > 0:
#		if _current_right_number == _correct_number:
#			correct_hit()
#		else:
#			decrease_hp()
		shake()



func _process(delta):
	var _factor_progress = _runtime_data.factor_progress
	_factor_progress -= delta * 10
	if _factor_progress < 0:
		if _factor_total > 0:
			_factor_total -= 1
			_factor_progress += 100
		else:
			_factor_progress = 0
	_runtime_data.factor_progress = _factor_progress

func factor_logic(is_correct):
	var _factor_progress = _runtime_data.factor_progress
	if is_correct:
		_factor_progress += 12
		if _factor_progress >= 100:
			_factor_progress = 10
			if _factor_total <= 10:
				_factor_total += 1
		else:
			_factor_progress = 100
	elif _factor_total > 0 or _factor_progress > PROGRESS_FACTOR_DEPRECIATION:
		_factor_progress -= PROGRESS_FACTOR_DEPRECIATION
	_runtime_data.factor_progress = _factor_progress




func _on_setted_beat_multiplier(multiplier):
	if multiplier == 0:
		_beat_multiplier = 0
	elif multiplier == 1:
		_beat_multiplier = 1
	elif multiplier == 2:
		_beat_multiplier = 10



func _on_beat(_beat, measure, tempo):
	#if measure == 8:
	fireing_humans.spawn_human()


func shake():
	self.set_global_position(Vector2(0,7))
	await get_tree().create_timer(0.1).timeout
	self.set_global_position(Vector2(0,0))


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
		score += 1
	else:
		score -= 1
		if score <= 0:
			score = 0
	GameEvents.emit_signal("scored", score)

func lose_hp():
	hp -= 1
	if hp <= 0:
		hp = 0
		print("GameOver")
	print("Hp: " + str(hp))
	GameEvents.emit_signal("hp_changed", hp)


func _on_fireing_humans_flamed(_is_human_burned):
	points_logic(_is_human_burned)
	#$MusicBars.color_bars(_is_human_burned)

func _on_fireing_humans_human_escaped():
	lose_hp()
