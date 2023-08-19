extends Node

enum COLOR{RED, BLUE}
@export var animations = {
	COLOR.RED: preload("res://Code/Entities/goblin_red.tres"),
	COLOR.BLUE: preload("res://Code/Entities/goblin_blue.tres"),
}
@export var node: AnimatedSprite2D
var current_color: COLOR = COLOR.RED:
	set(new):
		current_color = new
		node.sprite_frames = animations[current_color]


func _init():
	GameEvents.new_factor_sum.connect(_on_factor_value_change)


func _on_factor_value_change(value):
	if value >= 11:
		current_color = COLOR.BLUE
	elif current_color == COLOR.BLUE:
		current_color = COLOR.RED
