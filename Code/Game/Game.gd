extends Node2D

const PROGRESS_FACTOR_DEPRECIATION = 25
const SPACE_ALLOWANCE_MSEC = 100
const BEAT_TIME_MSEC = 571
@export var _runtime_data: RuntimeData
var _current_number_pool: Array
var _correct_number: int
var _current_left_number: int
var _current_right_number: int
var _factor_total: int:
	set(val):
		_factor_total = val
		GameEvents.emit_signal("factor_total_changed", val)
var _disable_action = false
var _beat_multiplier: int = 0
var score = 0
var _last_music_beat_time_stamp: int = 0



func _ready():
	GameEvents.new_boxes_number_picked.connect(_on_new_boxes_number_picked)
	GameEvents.new_pool_picked.connect(_on_new_pool_picked)
	GameEvents.space_clicked.connect(_on_space_clicked)
	GameEvents.beat.connect(_on_beat)
	GameEvents.setted_beat_multiplier.connect(_on_setted_beat_multiplier)

func _input(event):
	if event.is_action_pressed("ui_left") and _factor_total > 0:
		if _current_left_number == _correct_number:
			correct_hit()
		else:
			decrease_hp()
		shake()
	if event.is_action_pressed("ui_right") and _factor_total > 0:
		if _current_right_number == _correct_number:
			correct_hit()
		else:
			decrease_hp()
		shake()
	if event.is_action_pressed("ui_accept"):
		space_clicked()


func _process(delta):
	var _factor_progress = _runtime_data.factor_progress
	_factor_progress -= delta * 10
	if _factor_progress < 0:
		if _factor_total > 0:
			_factor_total -= 1
			_factor_progress = 100
		else:
			_factor_progress = 0
	_runtime_data.factor_progress = _factor_progress

func _on_space_clicked(is_correct: bool):
	var _factor_progress = _runtime_data.factor_progress
	if is_correct == true:
		_factor_progress += 12
		if _factor_progress >= 100:
			_factor_progress = 10
			if _factor_total <= 10:
				_factor_total += 1
			else:
				_factor_progress = 100
	else:
		if _factor_total > 0 or _factor_progress > PROGRESS_FACTOR_DEPRECIATION:
			_factor_progress -= PROGRESS_FACTOR_DEPRECIATION
	_runtime_data.factor_progress = _factor_progress

func correct_hit():
	var action = Action.new()
	action.type = Action.TYPES.POINT
	get_action(action)

func decrease_hp():	
	var action = Action.new()
	action.type = Action.TYPES.HP
	get_action(action)

func get_action(action: Action):
	if _disable_action == true:
		return
	if action.type == Action.TYPES.POINT:
		score += 1 * _factor_total * _beat_multiplier
	action.value = score
	GameEvents.emit_signal("action_made", action)



func _on_setted_beat_multiplier(multiplier):
	if multiplier == 0:
		_beat_multiplier = 0
	elif multiplier == 1:
		_beat_multiplier = 1
	elif multiplier == 2:
		_beat_multiplier = 10



func _on_beat(_beat, measure, tempo):
	_last_music_beat_time_stamp = Time.get_ticks_msec()


func shake():
	self.set_global_position(Vector2(0,7))
	await get_tree().create_timer(0.1).timeout
	self.set_global_position(Vector2(0,0))

func space_clicked():
	var _current_time_stamp = Time.get_ticks_msec()
	var is_correct: bool 
	var difference = abs(_last_music_beat_time_stamp - _current_time_stamp)
	print(difference, " > ", BEAT_TIME_MSEC - SPACE_ALLOWANCE_MSEC)
	if difference < SPACE_ALLOWANCE_MSEC or difference > BEAT_TIME_MSEC - SPACE_ALLOWANCE_MSEC:
		is_correct = true
	else:
		is_correct = false
	GameEvents.emit_signal("space_clicked", is_correct)


func _on_new_pool_picked(new_pool):
	_current_number_pool = new_pool
	_correct_number = new_pool[0]

func _on_new_boxes_number_picked(left: int, right: int):
	_current_left_number = left
	_current_right_number = right
