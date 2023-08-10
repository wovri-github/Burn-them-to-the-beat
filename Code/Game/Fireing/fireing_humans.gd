extends Node2D

signal human_escaped
signal flamed(burned_humans_count: int)

const BEGINNING_DISTANCE = 550
@export var is_debug = true
var mock_beat = 0
var is_endless = false
var position_distance_speed = 10
var human_tscn = preload("res://Code/Entities/human.tscn")
var active_measures: Array = []
var spawn_distance: float = 0
var offset_sec:float = 0
var spawn_calls_in_one_beat = 0
@onready var distance = ($HumanSpawn.position.x - $Fire.position.x) 
@onready var speed = distance / (Defaluts.BEAT_OFFSET * Defaluts.BEAT_SEC)



func spawn_distance_logic() -> int:
	if 1000 <= spawn_distance:
		return 0
	if 400 < spawn_distance:
		return 1
	if 250 < spawn_distance:
		return 3
	if 150 < spawn_distance:
		return 5
	if 100 < spawn_distance:
		return 7
	return 10

func _ready():
	if is_debug:
		is_endless = true
	random_measures()
	GameEvents.beat.connect(_on_beat)

func spawn_human():
	$HumanSpawn.position.x = spawn_distance + BEGINNING_DISTANCE
	distance = ($HumanSpawn.position.x - $Fire.position.x) 
	speed = calculate_speed()
	
	var human_inst = human_tscn.instantiate()
	human_inst.init(speed, $HumanSpawn.position)
	add_child(human_inst)

func calculate_speed() -> float:
	return distance / ((Defaluts.BEAT_OFFSET * Defaluts.BEAT_SEC) - offset_sec)

func story_spawn_logick(_beat):
	if _beat == 2:
		active_measures = [4]
	if _beat == 8:
		active_measures = [4,5,6]
	if _beat == 16:
		active_measures = [1,4,7]
	if _beat == 24:
		active_measures = [1,3,5,7]
	if _beat == 32:
		active_measures = [2,3,4,5,5,7,8]
	if _beat == 40:
		active_measures = [2,7,8]
	if _beat == 56:
		active_measures = [4,5,6]
	if _beat == 65:
		spawn_calls_in_one_beat = 2
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 89:
		spawn_calls_in_one_beat = 0
		active_measures = []
	if _beat == 160:
		active_measures = [1, 3, 5, 7]
	if _beat == 193:
		spawn_calls_in_one_beat = 4
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 224:
		spawn_calls_in_one_beat = 0

func random_spawn_logick(_beat):
	if _beat % 8 == 0:
		random_measures()
	if _beat == 65:
		spawn_calls_in_one_beat = 2
	if _beat == 89:
		spawn_calls_in_one_beat = 0
	if _beat == 129:
		spawn_calls_in_one_beat = 2
	if _beat == 161:
		spawn_calls_in_one_beat = 0
	if _beat == 193:
		spawn_calls_in_one_beat = 4
	if _beat == 224:
		spawn_calls_in_one_beat = 0

func random_measures():
	var size = randi_range(2, 8)
	var all_mesures = [1,2,3,4,5,6,7,8]
	var new_mesures = []
	for i in size:
		new_mesures.append(all_mesures.pick_random())
	active_measures = new_mesures

func multi_spawn():
	var time_every_call = Defaluts.BEAT_SEC / spawn_calls_in_one_beat
	for i in spawn_calls_in_one_beat:
		spawn_human()
		await get_tree().create_timer(time_every_call).timeout


func _on_beat(beat, measure, _offset_sec):
	offset_sec = _offset_sec
	if is_endless: 
		spawn_distance += spawn_distance_logic()
		random_spawn_logick(beat)
	else:
		story_spawn_logick(beat)
	
	multi_spawn()
	if measure in active_measures:
		spawn_human()


func _on_delete_area_area_exited(area):
	emit_signal("human_escaped")
	area.die()

	

