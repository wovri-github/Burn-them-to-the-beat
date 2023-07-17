extends NinePatchRect

@export var dialoge: Dialogue
@export var second_dialoge: Dialogue
@onready var max_slides = dialoge.dialog_end_beat.size()
var current_dialoge_id = 0
var dialoge_beat_offset = 0
@onready var label = $Label



func _ready():
	GameEvents.beat.connect(_on_beat)

func _on_beat(beat, mesure, tempo):
	beat -= 2
	beat -= dialoge_beat_offset
	if current_dialoge_id < max_slides  and beat == dialoge.dialog_starting_beat[current_dialoge_id]:
		$Label.text = dialoge.dialog_slides[current_dialoge_id]
		self.show()
		current_dialoge_id += 1
	if current_dialoge_id <= max_slides  and beat == dialoge.dialog_end_beat[current_dialoge_id-1]:
		self.hide()

func start_second_dialoge(starting_second_story_beat):
	dialoge_beat_offset = starting_second_story_beat
	current_dialoge_id = 0
	dialoge = second_dialoge
	max_slides = dialoge.dialog_end_beat.size()

func get_dialoge(dialoge: Dialogue, starting_beat: int):
	pass
