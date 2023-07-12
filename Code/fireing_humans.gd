extends Node2D

var human_tscn = preload("res://Code/human.tscn")
@onready var distance = ($HumanSpawn.position.x - $Fire.position.x) 
@onready var speed = distance / 1


func _ready():
	spawn_human()

func spawn_human():
	var human_inst = human_tscn.instantiate()
	human_inst.init(speed)
	$HumanSpawn.add_child(human_inst)
