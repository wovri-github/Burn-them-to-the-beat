extends Control

@onready var all_bars = self.get_children()

func _ready():
	GameEvents.beat.connect(_on_music_beat)

func color_bars(is_correct):
	if is_correct == true:
		for bar in all_bars:
			bar.make_color(Color.GREEN_YELLOW)
	else:
		for bar in all_bars:
			bar.make_color(Color.BROWN)

func _on_music_beat(_beat, _measure, _tempo):
	_beat *= _tempo
	if typeof(_beat) != TYPE_FLOAT:
		for bar in all_bars:
			bar.grow_bars()
