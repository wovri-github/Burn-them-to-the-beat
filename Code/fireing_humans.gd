extends Node2D

signal human_escaped
signal flamed(_is_human_burned: bool)

const BEGINNING_DISTANCE = 550
var position_distance_speed = 10
var human_tscn = preload("res://Code/human.tscn")
var active_measures: Array = []
var spawn_distance: float = 0
@onready var distance = ($HumanSpawn.position.x - $Fire.position.x) 
@onready var speed = distance / (Defaluts.BEAT_OFFSET * Defaluts.BEAT_SEC)

func spawn_distance_logic() -> int:
	if 500 < spawn_distance:
		return 1
	if 300 < spawn_distance:
		return 3
	if 200 < spawn_distance:
		return 5
	if 100 < spawn_distance:
		return 7
	return 10
	

func _ready():
	GameEvents.beat.connect(_on_beat)


func _process(delta):
	if get_parent().is_endless:
		position_distance_speed = spawn_distance_logic()
		spawn_distance += delta * position_distance_speed

	
	$HumanSpawn.position.x = spawn_distance + BEGINNING_DISTANCE
	distance = ($HumanSpawn.position.x - $Fire.position.x) 

	speed = distance / (Defaluts.BEAT_OFFSET * Defaluts.BEAT_SEC)

func spawn_human():
	var human_inst = human_tscn.instantiate()
	human_inst.init(speed, $HumanSpawn.position)
	
	add_child(human_inst)

func story_spawn_logick(_beat):
	if _beat == 1:
		active_measures = [3]
	if _beat == 8:
		active_measures = [1,2,3]
	if _beat == 16:
		active_measures = [1,4,7]
	if _beat == 24:
		active_measures = [1,3,5,7]
	if _beat == 32:
		active_measures = [2,3,4,5,5,7,8]
	if _beat == 40:
		active_measures = [2,7,8]
	if _beat == 56:
		active_measures = [6,7,8]
	if _beat == 64:
		double_spawn(true)
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 88:
		double_spawn(false)
		active_measures = []
#	if _beat == 128:
#		double_spawn(true)
#		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 160:
		double_spawn(false)
		active_measures = [1, 3, 5, 7]
	if _beat == 192:
		quadra_spawn(true)
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 224:
		quadra_spawn(false)


func random_spawn_logick(_beat):
	if _beat % 8 == 0:
		random_measures()
	if _beat == 64:
		double_spawn(true)
	if _beat == 88:
		double_spawn(false)
	if _beat == 128:
		double_spawn(true)
	if _beat == 160:
		double_spawn(false)
	if _beat == 192:
		quadra_spawn(true)
	if _beat == 224:
		quadra_spawn(false)

func random_measures():
	var size = randi_range(2, 8)
	var all_mesures = [1,2,3,4,5,6,7,8]
	var new_mesures = []
	for i in size:
		new_mesures.append(all_mesures.pick_random())
	active_measures = new_mesures


func double_spawn(is_on):
	if is_on:
		await get_tree().create_timer(0.2857).timeout
		$SecondSpawn.start(0.2857)
	else:
		$SecondSpawn.stop()

func quadra_spawn(is_on):
	if is_on:
		await get_tree().create_timer(0.1428).timeout
		$SecondSpawn.start(0.1428)
	else:
		$SecondSpawn.stop()
		

func _on_beat(beats, measure, tempo):
	if not get_parent().is_endless:
		story_spawn_logick(beats)
	else:
		random_spawn_logick(beats)
	if measure in active_measures:
		spawn_human()


func _on_delete_area_area_exited(area):
	emit_signal("human_escaped")
	area.die()


func _on_second_spawn_timeout():
	spawn_human()
