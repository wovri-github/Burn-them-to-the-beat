extends Node

signal round_out()
signal music_bit_timeout()
signal double_beated()
signal beated_8(beat_multiplier)


const MAX_ROUNDTIME = 8
const SEC_FOR_BEAT = 1/(105 / 60)
@export var round_time = 4
@onready var Music = $AudioStreamPlayer
@onready var MusicBit = %MusicBit
@onready var Beat8 = %Beat8
var beat_counter = 0
var double_beat = 1
var beat_multiplier = 1
var game_time = 0

func start_game():
	Music.play()
	Beat8.start(4.571)
	$GameTime.start()

func end_game():
	$GameTime.stop()
	Beat8.stop()
	beat_counter = 0
	double_beat = 1
	beat_multiplier = 1
	game_time = 0
	Music.stop()

func count_down():
	if double_beat == 0:
		double_beat = 1
		round_time -= 1
		if round_time < 1:
			round_time = MAX_ROUNDTIME
			emit_signal("round_out")
		emit_signal("double_beated")
	else:
		double_beat = 0

func set_up_music_bit(multiplier):
	if multiplier == 0:
		beat_multiplier = 0
		MusicBit.stop()
		return
	if multiplier == 1:
		beat_multiplier = 1
	if multiplier == 2:
		beat_multiplier = 10
	
	var bmp = Music.stream.get_bpm()
	var sec_for_beat = 1/(bmp / 60 * multiplier)
	MusicBit.start(sec_for_beat)


func _on_music_bit_timeout():
	count_down()
	emit_signal("music_bit_timeout")


func _on_beat_8_timeout():
	beat_counter += 1
	if beat_counter == 1:
		set_up_music_bit(1)
	if beat_counter == 8:
		set_up_music_bit(2)
	if beat_counter == 11:
		set_up_music_bit(0)
	if beat_counter == 12:
		set_up_music_bit(1)
	if beat_counter == 16:
		set_up_music_bit(2)
	if beat_counter == 20:
		set_up_music_bit(1)
	if beat_counter == 24:
		set_up_music_bit(2)
	if beat_counter == 28:
		set_up_music_bit(0.5)
	if beat_counter == 33:
		beat_counter = 0
	emit_signal("beated_8", beat_multiplier)


func _on_game_time_timeout():
	game_time += 1
