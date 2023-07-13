@tool
extends Area2D

@export var flame_big_scale: float = 3



func _ready():
	$Sprite.set_scale(Vector2.ONE)
	$Sprite.play("fire")


func _input(event):
	if event.is_action_pressed("ui_accept"):
		big_flame()
		burn_human()


func big_flame():
	$Sprite.set_scale(Vector2(flame_big_scale, flame_big_scale))
	$FlameTimer.start()


func burn_human():
	var humans_on_fire = self.get_overlapping_areas()
	var _is_human_burned = false
	if humans_on_fire:
		_is_human_burned = true
		for human in humans_on_fire:
			human.die()
	get_parent().emit_signal("flamed", _is_human_burned)


func _on_flame_timer_timeout():
	$Sprite.set_scale(Vector2.ONE)
