extends Node


@export var node_to_move: Node
@export_category("Parameters")
@export var amplitude = 2
@export var duration = 0.02
@export var max_trembles = 3
@export var tremble_number = 0



func start():
	tremble()

func tremble():
	tremble_number += 1
	var rand: Vector2
	rand.x = randi_range(-amplitude, amplitude)
	rand.y = randi_range(-amplitude, amplitude)
	var tween = get_tree().create_tween()
	tween.tween_property(node_to_move, "position", rand, duration)
	if tremble_number >= max_trembles:
		tween.tween_callback(stop_tremble)
	else:
		tween.tween_callback(tremble)

func stop_tremble():
	var tween = get_tree().create_tween()
	tween.tween_property(node_to_move, "position", Vector2.ZERO, duration)
	tremble_number = 0
