extends Control


@onready var left_group = $LeftGroup
@onready var left_bars = $LeftGroup.get_children()
@onready var right_group = $RightGroup
@onready var right_bars = $RightGroup.get_children()


func _ready():
	GameEvents.beat.connect(_on_beat)
	GameEvents.hit_made.connect(_on_hit_made)


func show_left_group():
	left_group.show()

func show_right_group():
	right_group.show()


func color_bars(color: Color, bars: Array):
	for bar in bars:
		bar.current_color = color


func _on_beat(_beat, _measure, _tempo):
	var bars
	if _beat % 2 == 1:
		bars = left_bars
	else:
		bars = right_bars
	
	for bar in bars:
		bar.is_growth = true


func _on_hit_made(is_correct, is_left_side):
	var color: Color
	var bars: Array
	if is_correct:
		color = Color.GREEN_YELLOW
	else:
		color = Color.BROWN
	if is_left_side:
		bars = left_bars
	else:
		bars = right_bars
	
	color_bars(color, bars)
