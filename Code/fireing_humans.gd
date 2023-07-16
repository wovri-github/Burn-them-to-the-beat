extends Node2D

signal human_escaped
signal flamed(_is_human_burned: bool)

var human_tscn = preload("res://Code/human.tscn")
var active_measures: Array = []
@onready var distance = ($HumanSpawn.position.x - $Fire.position.x) 
@onready var speed = distance / 1.142857143

func _ready():
	GameEvents.beat.connect(_on_beat)


func spawn_human():
	var human_inst = human_tscn.instantiate()
	human_inst.init(speed)
	$HumanSpawn.add_child(human_inst)

func spawn_logick(_beat):
	if _beat == 1:
		active_measures = [3]
	if _beat == 8:
		active_measures = [1,2]
	if _beat == 16:
		active_measures = []
	if _beat == 24:
		active_measures = [1,3,5,7]
	if _beat == 32:
		active_measures = [2,3,4,5,5,7,8]
	if _beat == 40:
		active_measures = [1,3,5,7]
	if _beat == 56:
		active_measures = [6,7,8]
	if _beat == 64:
		double_spawn(true)
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 88:
		double_spawn(false)
		random_measures()
	if _beat == 96:
		random_measures()
	if _beat == 104:
		random_measures()
	if _beat == 112:
		random_measures()
	if _beat == 120:
		random_measures()
	if _beat == 128:
		double_spawn(true)
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 160:
		double_spawn(false)
		active_measures = [1, 3, 5, 7]
	if _beat == 192:
		quadra_spawn(true)
		active_measures = [1, 2, 3, 4, 5, 6, 7, 8]
	if _beat == 224:
		quadra_spawn(false)
	return active_measures

func random_measures():
	var size = randi_range(1, 8)
	var all_mesures = [1,2,3,4,5,6,7,8]
	var new_mesures = []
	for i in size:
		new_mesures.append(all_mesures.pick_random())
	active_measures = new_mesures


func double_spawn(is_on):
	if is_on:
		await get_tree().create_timer(0.2857).timeout
		$SecondSpawn.start(0.5714)
	else:
		$SecondSpawn.stop()

func quadra_spawn(is_on):
	if is_on:
		await get_tree().create_timer(0.1428).timeout
		$SecondSpawn.start(0.1428)
	else:
		$SecondSpawn.stop()
		

func _on_beat(beats, measure, tempo):
	spawn_logick(beats)
	if measure in active_measures:
		spawn_human()


func _on_delete_area_area_exited(area):
	emit_signal("human_escaped")
	area.die()


func _on_second_spawn_timeout():
	spawn_human()
