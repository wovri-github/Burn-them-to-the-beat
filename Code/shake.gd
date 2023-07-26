extends Node

@export var force = 10
@export var repeat = 5
@export var single_shake_sec = 0.1
@export var node_to_shake: Node


func shake():
	var tween = get_tree().create_tween()
	for i in range(repeat):
		var random_x = randi_range(-force, force)
		var random_y = randi_range(0, force)
		var random_force = Vector2(random_x, random_y)
		tween.tween_property(node_to_shake, "position", random_force, single_shake_sec)
	node_to_shake.position = Vector2.ZERO

