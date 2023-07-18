extends Control

signal show_left_side()

@export var runtime_data: RuntimeData
@export var init_dialog: Dialogue
var is_factor_progress_above_30 = false
var is_second_story = false
var starting_second_story_beat: int = -1
@onready var main_text_box = $MainTextBox



func _ready():
	GameEvents.beat.connect(_on_beat)
	

func init_story(_beat):
	if _beat == 1:
		main_text_box.get_dialoge(init_dialog, _beat)


func story(_beat):
	if _beat == 88:
		emit_signal("show_left_side")
	if is_factor_progress_above_30 and not is_second_story:
		is_second_story = true
		var rest = _beat % 2
		if rest == 1:
			starting_second_story_beat = _beat + 1
		else:
			starting_second_story_beat = _beat + 2


func second_story(_beat):
	if _beat == starting_second_story_beat:
		$MainTextBox.start_second_dialoge(starting_second_story_beat)
	if _beat == starting_second_story_beat + 10:
		get_parent().get_node("HitGoblinManager/GoblinR").show()
	if _beat == starting_second_story_beat + 15:
		get_parent().get_node("HitGoblinManager").right_on = true
		get_parent().get_node("MusicBars").show_right_group()





func _on_beat(_beat, measure, tempo):
	init_story(_beat)
	if _beat >= 88:
		story(_beat)
		if is_second_story == true:
			second_story(_beat)


func _on_hit_goblin_manager_hit_made(is_correct, is_left_side):
	if is_correct:
		$MainTextBox.hide()
	if runtime_data.factor_progress >= 30:
		is_factor_progress_above_30 = true
		$"../HitGoblinManager".disconnect("hit_made",_on_hit_goblin_manager_hit_made)
