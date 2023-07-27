extends Control

signal game_over(is_win)

@onready var sequence = [
	"Get Ready",
	"Use Space with rythm",
	"",
]
@onready var counter = $Counter
@onready var HP = $HP
@onready var FactorText = $Factor/Label
@onready var FactorProg = $Factor/ProgressBar
@onready var score_manager = $ScoreManager
@onready var pause_menu = $PauseMenu
var sequence_counter = 0
var _factor_total: int
var _beat_multiplier: int
var was_info = false

var is_factor_first_time = true



func _ready():
	GameEvents.hit_made.connect(_on_hit_made)
#	change_sequence()
#	GameEvents.music_beat.connect(_on_music_bit_timeout)
	GameEvents.new_factor_sum.connect(_on_new_factor_sum)
#	GameEvents.setted_beat_multiplier.connect(_on_setted_beat_multiplier)
	pause_menu.hide()



func _on_hit_made(is_correct, is_left_side):
	if is_factor_first_time:
		is_factor_first_time = false
		$Factor.show()

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

	

func change_sequence():
	if sequence_counter > 2:
		return
		#disconnect("beated_8", change_sequence)
	$Info.text = sequence[sequence_counter]
	sequence_counter += 1


func _on_new_factor_sum(value):
	
	if value == 11:
		FactorText.set_text("[x11] (MAX)")
	else:
		FactorText.set_text("[x" + str(value)+"]")
#	if not was_info and value == 1: 
#		was_info = true
#		$Info.text = "Click for points!"
#		await get_tree().create_timer(4.5).timeout
#		$Info.text = ""
	

func _on_pause_pressed():
	change_pause_menu_state(true)

func _on_resume_pressed():
	change_pause_menu_state(false)

func change_pause_menu_state(is_on):
	get_tree().set_pause(is_on)
	if is_on:
		pause_menu.show()
	else:
		pause_menu.hide()
	


func _on_leave_pressed():
	get_tree().set_pause(false)
	emit_signal("game_over", false)
