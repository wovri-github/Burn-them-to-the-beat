extends Node2D

signal human_escaped
signal flamed(_is_human_burned: bool)

var human_tscn = preload("res://Code/human.tscn")
@onready var distance = ($HumanSpawn.position.x - $Fire.position.x) 
@onready var speed = distance / 1.142857143


func spawn_human():
	var human_inst = human_tscn.instantiate()
	human_inst.init(speed)
	$HumanSpawn.add_child(human_inst)


func _on_delete_area_area_exited(area):
	emit_signal("human_escaped")
	area.die()
