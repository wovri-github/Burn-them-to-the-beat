extends Control

@onready var sequence = [
	"Get Ready",
	"Use Space with rythm",
	"",
]
@onready var counter = $Counter
@onready var HP = $HP
@onready var FactorText = $Factor/Label
@onready var FactorBeat = $Factor/LabelBeat
@onready var FactorProg = $Factor/ProgressBar
@onready var score_manager = $ScoreManager
var sequence_counter = 0
var _factor_total: int
var _beat_multiplier: int
var was_info = false



func _ready():
#	change_sequence()
#	GameEvents.music_beat.connect(_on_music_bit_timeout)
#	GameEvents.factor_total_changed.connect(_on_factor_total_changed)
#	GameEvents.setted_beat_multiplier.connect(_on_setted_beat_multiplier)
	GameEvents.losed_hp.connect(_on_losed_hp)

func _on_losed_hp(hp):
	pass



func _on_setted_beat_multiplier(multiplier):
	if multiplier == 0:
		_beat_multiplier = 0
	elif multiplier == 1:
		_beat_multiplier = 1
	elif multiplier == 2:
		_beat_multiplier = 10

func _on_music_bit_timeout(beat):
	pass
#	if beat % 8:
#		_on_beated_8()



func _on_beated_8():
	change_sequence()
	FactorBeat.set_text("(music) [x " + str(_beat_multiplier) + "]")
	

func change_sequence():
	if sequence_counter > 2:
		return
		#disconnect("beated_8", change_sequence)
	$Info.text = sequence[sequence_counter]
	sequence_counter += 1


func _on_factor_total_changed(value):
	_factor_total = value
	if value == 11:
		FactorText.set_text("(rythm) [x11] (MAX)")
	else:
		FactorText.set_text("(rythm) [x" + str(value)+"]")
	if not was_info and value == 1: 
		was_info = true
		$Info.text = "Click for points!"
		await get_tree().create_timer(4.5).timeout
		$Info.text = ""
	

func _on_leave_b_pressed():
	get_tree().change_scene_to_file("res://Code/Menu/EndTable.tscn")
