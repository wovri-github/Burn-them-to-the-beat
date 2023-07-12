@tool
extends AnimatedSprite2D

@export var flame_big_scale: float = 3:
	set(new_scale):
		flame_big_scale = new_scale
		self.set_scale(Vector2(flame_big_scale, flame_big_scale))



func _ready():
	self.set_scale(Vector2.ONE)
	self.play("fire")


func _input(event):
	if event.is_action_pressed("ui_accept"):
		big_flame()
		burn_human()


func big_flame():
	self.set_scale(Vector2(flame_big_scale, flame_big_scale))
	$FlameTimer.start()


func burn_human():
	var humans_on_fire = $Area2D.get_overlapping_areas()
	if humans_on_fire:
		for human in humans_on_fire:
			human.die()
	else:
		print("No humans!")


func _on_flame_timer_timeout():
	self.set_scale(Vector2.ONE)
