extends Node

const MIN = 0
const MAX = 10
const MAX_SIZE = 3

var _current_pool: Array
var _prev_left: int
var _prev_right: int



func _ready():
	GameEvents.music_beat.connect(_on_music_beat)
	create_random_pool()

func _on_music_beat(beat):
	if beat % 8:
		_on_round_out()
	if beat % 2:
		_on_double_beated()

func _on_round_out():
	create_random_pool()


func _on_double_beated(): 
	if _current_pool != null:
		var rand_left = _current_pool.pick_random()
		var rand_right = _current_pool.pick_random()
		while rand_left == _prev_left:
			rand_left = _current_pool.pick_random()
		while rand_right == _prev_left:
			rand_right = _current_pool.pick_random()
		GameEvents.emit_signal("new_boxes_number_picked", rand_left, rand_right)



func create_random_pool():
	_current_pool.clear()
	while _current_pool.size() < MAX_SIZE:
		var random_i = randi_range(MIN, MAX)
		if _current_pool.has(random_i):
			continue
		else:
			_current_pool.append(random_i)

	GameEvents.emit_signal("new_pool_picked", _current_pool)

