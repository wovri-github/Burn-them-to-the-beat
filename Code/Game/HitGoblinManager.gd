extends Node2D

signal hit_made(is_correct: bool, is_left_side: bool)

const deviation_sec = 0.180
var left_on = false
var right_on = false
@onready var GoblinsL = [$GoblinL, $GoblinL2]
@onready var GoblinsR = [$GoblinR, $GoblinR2]


func _ready():
	GameEvents.new_factor_sum.connect(_on_new_factor_sum)
	GameEvents.beat.connect(_on_beat)


func _on_beat(_song_position_in_beats: int, _measure: int, tempo: int):
	await get_tree().create_timer(1.1).timeout
	if _song_position_in_beats % 2 == 1:
		$HitTimerLeft.start(deviation_sec)
	else:
		$HitTimerRight.start(deviation_sec)
	

func _input(event):
	if event.is_action_pressed("ui_left") and left_on:
		check_timer_left()
		shake()
	if event.is_action_pressed("ui_right") and right_on:
		check_timer_right()
		shake()


func check_timer_left():
	if $HitTimerLeft.is_stopped():
		self.emit_signal("hit_made", false, true)
	else:
		$HitTimerLeft.stop()
		self.emit_signal("hit_made", true, true)

func check_timer_right():
	if $HitTimerRight.is_stopped():
		self.emit_signal("hit_made", false, false)
	else:
		$HitTimerRight.stop()
		self.emit_signal("hit_made", true, false)

func shake():
	get_parent().set_global_position(Vector2(0,7))
	await get_tree().create_timer(0.1).timeout
	get_parent().set_global_position(Vector2(0,0))


func _on_new_factor_sum(factor):
#	if factor == 2:
#		GoblinsR[1].hide()
#		return
	if factor == 3:
		GoblinsR[1].show()
#		GoblinsL[1].hide()
		return
	if factor == 4:
		GoblinsL[1].show()
		return
