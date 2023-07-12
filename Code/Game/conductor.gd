extends AudioStreamPlayer


@export var _offset_speed = 2
@export var _max_measures: int = self.stream.get_bar_beats() * _offset_speed
@export var _bpm: int = self.stream.get_bpm() * _offset_speed

var _sec_per_beat = 60.0 / _bpm
var _song_position_in_beats: int= 1
var _last_reported_beat = _offset_speed
var _measure = _offset_speed
var _tempo := 0
var _beats_before_start = 0
var time_begin
var time_delay

@onready var offset_beat_timer = $OffsetBeatTimer



func _ready():
	play_with_beat_offset(17)

func start_music():
	time_begin = Time.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	self.play()

func _process(delta):
	if self.is_playing():
		var _song_position = (Time.get_ticks_usec() - time_begin) / 1000000.0
		_song_position -= time_delay
		_song_position = max(0, _song_position)
		_song_position_in_beats = int(_song_position / _sec_per_beat) + _offset_speed
		report_beat()

func report_beat():
	if _last_reported_beat < _song_position_in_beats:
		_measure = (_last_reported_beat % _max_measures) +1
		_last_reported_beat = _song_position_in_beats
		tempo_logick(_song_position_in_beats)
		GameEvents.emit_signal("beat", _song_position_in_beats, _measure, _tempo)
		print("Beat: " + str(_song_position_in_beats) + " Measure: " + str(_measure))

func play_with_beat_offset(num):
	_beats_before_start = num
	offset_beat_timer.start(_sec_per_beat)



func tempo_logick(_beat):
	_beat /= 2
	if _beat == 8:
		_tempo = (0.5)
	if _beat == 64:
		_tempo = (1)
	if _beat == 88:
		_tempo = (0.5)
	if _beat == 128:
		_tempo = (1)
	if _beat == 160:
		_tempo = (0.5)
	if _beat == 192:
		_tempo = (1)
	if _beat == 224:
		_tempo = (0.5)
	GameEvents.emit_signal("music_beat", _beat)



func _on_finished():
	_tempo = 0
	_song_position_in_beats = 1
	_last_reported_beat = _offset_speed
	_measure = _offset_speed
	start_music()


func _on_offset_beat_timer_timeout():
	report_beat()
	if _song_position_in_beats == _beats_before_start -1:
		offset_beat_timer.stop()
		_song_position_in_beats = 1
		_last_reported_beat = _offset_speed
		start_music()
		return
	_song_position_in_beats += 1
