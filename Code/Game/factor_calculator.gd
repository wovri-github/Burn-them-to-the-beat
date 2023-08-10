extends Node

const PROGRESS_FACTOR_DEPRECIATION = 75
@export var _runtime_data: RuntimeData
var _factor_sum: int = 1:
	set(val):
		_factor_sum = val
		GameEvents.emit_signal("new_factor_sum", val)


func _ready():
	GameEvents.hit_made.connect(_on_hit_made)
	await get_tree().process_frame
	GameEvents.emit_signal("new_factor_sum", _factor_sum)

func _process(delta):
	continuous_factor_depreciation(delta)


func continuous_factor_depreciation(delta):
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


func _on_hit_made(is_correct, is_left_side):
	factor_logic(is_correct)
