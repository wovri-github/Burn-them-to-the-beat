extends Control

@onready var left_bars = $Collector/LeftGroup.get_children()
@onready var right_bars = $Collector/RightGroup.get_children()
@onready var all_bars: Array


func _ready():
	GameEvents.beat.connect(_on_beat)
	GameEvents.hit_made.connect(_on_hit_made)
	all_bars.append_array(left_bars)
	all_bars.append_array(right_bars)
	

func show_left_group():
	$ColorRect.show()
	$Collector/LeftGroup.show()
func show_right_group():
	$Collector/RightGroup.show()

func color_bars(is_correct, is_left_side):
	if is_correct == true:
		if is_left_side:
			for bar in left_bars:
				bar.make_color(Color.GREEN_YELLOW)
		else:
			for bar in right_bars:
				bar.make_color(Color.GREEN_YELLOW)
	else:
		if is_left_side:
			for bar in left_bars:
				bar.make_color(Color.BROWN)
		else:
			for bar in right_bars:
				bar.make_color(Color.BROWN)

func _on_beat(_beat, _measure, _tempo):
	if _beat % 2 == 1:
		for bar in left_bars:
			bar.grow_bars()
	else:
		for bar in right_bars:
			bar.grow_bars()


func _on_hit_made(is_correct, is_left_side):
	color_bars(is_correct, is_left_side)
