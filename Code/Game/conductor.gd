extends AudioStreamPlayer


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

var _prev_tick = 0

@onready var offset_beat_timer = $OffsetBeatTimer



func _ready():
	play_with_beat_offset(3)
	#play_from_beat(50)

func start_music():
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	self.play()

func _process(delta):
	if self.is_playing():
		var song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		_song_position_in_beats = int(floor(song_position / _sec_per_beat)) + _beats_before_start
		report_beat()

func report_beat():
	if _last_reported_beat < _song_position_in_beats:
		_measure = (_last_reported_beat % _max_measures) +1
		_last_reported_beat = _song_position_in_beats
#		tempo_logick(_song_position_in_beats)
		GameEvents.emit_signal("beat", _song_position_in_beats, _measure, _tempo)
#		print("Beat: " + str(_song_position_in_beats)\
#				 + " Measure: " + str(_measure)\
#				 + " Time diff: " + str(Time.get_ticks_msec() - _prev_tick))
		_prev_tick = Time.get_ticks_msec()

func play_from_beat(beat):
	play()
	seek(beat * _sec_per_beat)
	_beats_before_start = 3
	#play_with_beat_offset(beat)

func play_with_beat_offset(num):
	_beats_before_start = num
	offset_beat_timer.start(_sec_per_beat)



#func tempo_logick(_beat):
#	_beat /= 2
#	if _beat == 8:
#		_tempo = (0.5)
#	if _beat == 64:
#		_tempo = (1)
#	if _beat == 88:
#		_tempo = (0.5)
#	if _beat == 128:
#		_tempo = (1)
#	if _beat == 160:
#		_tempo = (0.5)
#	if _beat == 192:
#		_tempo = (1)
#	if _beat == 224:
#		_tempo = (0.5)
#	GameEvents.emit_signal("music_beat", _beat)



func _on_finished():
	_tempo = 0
	_song_position_in_beats = 1
	_last_reported_beat = 1
	_measure = 1
	print("YouWin!")
	#start_music()


func _on_offset_beat_timer_timeout():
	_song_position_in_beats += 1
	if _song_position_in_beats == _beats_before_start-1:
		offset_beat_timer.start(_sec_per_beat - (AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()))
		
	if _song_position_in_beats == _beats_before_start:
		play()
		offset_beat_timer.stop()
		return
	report_beat()
