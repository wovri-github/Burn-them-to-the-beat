@tool
extends Node2D


const deviation_sec = 0.180
@export var is_left_goblin_visible: bool = false:
	set(new_state):
		is_left_goblin_visible = new_state
		$GoblinL.visible = is_left_goblin_visible
@export var is_right_goblin_visible: bool = false:
	set(new_state):
		is_right_goblin_visible = new_state
		$GoblinR.visible = is_right_goblin_visible
var left_on = false
var right_on = false


func _ready():
	if not Engine.is_editor_hint():
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
		GameEvents.emit_signal("hit_made", false, true)
	else:
		$HitTimerLeft.stop()
		GameEvents.emit_signal("hit_made", true, true)

func check_timer_right():
	if $HitTimerRight.is_stopped():
		GameEvents.emit_signal("hit_made", false, false)
	else:
		$HitTimerRight.stop()
		GameEvents.emit_signal("hit_made", true, false)

func shake():
	get_parent().set_global_position(Vector2(0,7))
	await get_tree().create_timer(0.1).timeout
	get_parent().set_global_position(Vector2(0,0))

func change_goblin_visibility(new_state):
	$GoblinL.visible = new_state
	$GoblinR.visible = new_state
