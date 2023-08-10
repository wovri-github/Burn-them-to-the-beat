extends Sprite2D

enum STATE{LEFT, MIDDLE, RIGHT}
@export var lever_state: STATE = STATE.MIDDLE:
	set(new):
		lever_state = new
		self.frame = lever_state

func _input(event):
	if event.is_action_pressed("ui_accept"):
		lever_state = STATE.LEFT
		$TurnOff.start(Defaluts.FIRE_TIME_SEC)


func _on_turn_off_timeout():
	lever_state = STATE.MIDDLE
