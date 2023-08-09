extends AudioStreamPlayer

signal game_over(is_win)

@export var _max_measures: int = self.stream.get_bar_beats()
@export var _bpm: int = self.stream.get_bpm()

var _sec_per_beat = 60.0 / _bpm
var _song_position_in_beats: int= 0
var _last_reported_beat = 0
var _measure
var _tempo := 0
var _beats_before_start = 0
var time_begin
var time_delay
var is_endless = false
var pitch_increment = 0.02

var offset_sec = 0
var ideal_beat_time = (60.0/105.0)
var beat = 1

var _prev_tick = 0

@onready var offset_beat_timer = $OffsetBeatTimer



func _ready():
	play_with_beat_offset(Defaluts.BEAT_OFFSET)
	#play_from_beat(86)

func _process(delta):
	if self.is_playing():
		var song_position = get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
		offset_sec = song_position - ideal_beat_time
		if offset_sec >= 0:
			report_beat()

func report_beat():
	_measure = (beat % _max_measures) + 1
	beat += 1
	ideal_beat_time = (beat - Defaluts.BEAT_OFFSET) * (60.0/105.0)
	GameEvents.emit_signal("beat", beat, _measure, offset_sec)

func play_from_beat(beat):
	play()
	seek(beat * _sec_per_beat)
	_beats_before_start = 3

func play_with_beat_offset(num):
	_beats_before_start = num
	offset_beat_timer.start(_sec_per_beat)



func _on_finished():
	await get_tree().create_timer(2).timeout
	_tempo = 0
	_song_position_in_beats = 1
	_last_reported_beat = 1
	_measure = 1
	if not is_endless:
		Storage.set_value("state", "activate_endless_mode", true)
		Storage.save()
		emit_signal("game_over", true)
	else:
		await get_tree().create_timer(1).timeout
		self.pitch_scale += pitch_increment
		play_with_beat_offset(Defaluts.BEAT_OFFSET)


func _on_offset_beat_timer_timeout():
	_song_position_in_beats += 1
	if _song_position_in_beats == _beats_before_start-1:
		offset_beat_timer.start(_sec_per_beat - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()))
		
	if _song_position_in_beats == _beats_before_start:
		play()
		offset_beat_timer.stop()
		return
	report_beat()
