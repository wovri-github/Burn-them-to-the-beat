extends Control

const MAX_HEALTH = 2
var health = MAX_HEALTH

var amplitude = 2
var duration = 0.02
var max_trembles = 3
var tremble_number = 0


func set_hp(value):
	$Texture.texture.set_current_frame(value)
	if value > 0:
		tremble()

func start_tremble():
	tremble()

func tremble():
	tremble_number += 1
	var rand: Vector2
	rand.x = randi_range(-amplitude, amplitude)
	rand.y = randi_range(-amplitude, amplitude)
	var tween = get_tree().create_tween()
	tween.tween_property($Texture, "position", rand, duration)
	if tremble_number >= max_trembles:
		tween.tween_callback(stop_tremble)
	else:
		tween.tween_callback(tremble)

func stop_tremble():
	var tween = get_tree().create_tween()
	tween.tween_property($Texture, "position", Vector2.ZERO, duration)
	tremble_number = 0
