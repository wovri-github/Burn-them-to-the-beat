extends AnimationPlayer

@export var runtime_data: RuntimeData
var is_second_story = false
var is_factor_progress_above_30 = false
var starting_second_story_beat: int = -1



func _ready():
	GameEvents.beat.connect(_on_beat)
	GameEvents.hit_made.connect(_on_hit_made)


func story(_beat):
	if _beat == 1:
		self.play("Story1")
	if _beat == 90:
		self.play("Story2")
	if _beat == starting_second_story_beat:
		self.play("Story3")


func check_story3_condition(_beat):
	if is_factor_progress_above_30 and not is_second_story:
		is_second_story = true
		var rest = _beat % 2
		if rest == 1:
			starting_second_story_beat = _beat + 1
		else:
			starting_second_story_beat = _beat + 2


func _on_beat(_beat, measure, tempo):
	check_story3_condition(_beat)
	story(_beat)

func _on_hit_made(is_correct, is_left_side):
	if is_correct and is_left_side and not is_factor_progress_above_30:
		$MarianTextBox.hide()
	if is_correct and not is_left_side:
		$AdamTextBox2.hide()
		GameEvents.disconnect("hit_made",_on_hit_made)
	if runtime_data.factor_progress >= 30:
		is_factor_progress_above_30 = true
