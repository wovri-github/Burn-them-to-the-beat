extends NinePatchRect

var dialoge: Dialogue
var current_dialoge_id = 0
var dialoge_beginning_beat = -99
var max_slides: int
var default_beat_duration = 4
var beat_duration: int
var is_in_dialoge := false
@onready var label = $Label


func _ready():
	GameEvents.beat.connect(_on_beat)

func _on_beat(beat, mesure, tempo):
	beat -= 2
	if beat == dialoge_beginning_beat:
		start_dialoge()
	if not is_in_dialoge:
		return
	beat_duration -= 1
	if beat_duration < 0:
		current_dialoge_id += 1
		if current_dialoge_id == max_slides:
			end_dialoge()
			return
		next_text()

func start_dialoge():
	is_in_dialoge = true
	$Label.text = dialoge.texts[current_dialoge_id]
	if dialoge.duration[current_dialoge_id] > 0:
		beat_duration = dialoge.duration[current_dialoge_id]
	else:
		beat_duration = default_beat_duration
	self.show()

func next_text():
	$Label.text = dialoge.texts[current_dialoge_id]
	if dialoge.duration[current_dialoge_id] > 0:
		beat_duration = dialoge.duration[current_dialoge_id]
	else:
		beat_duration = default_beat_duration

func end_dialoge():
	is_in_dialoge = false
	$Label.text = "Dialoge ends"
	dialoge = null
	self.hide()


func get_dialoge(new_dialoge: Dialogue, beginning_beat: int):
	dialoge_beginning_beat = beginning_beat
	current_dialoge_id = 0
	dialoge = new_dialoge
	max_slides = new_dialoge.texts.size()

func show_text_immediatly(new_text: String):
	assert(dialoge == null, "Text in wrong time")
	$Label.text = new_text
	$QuickTextTimer.start()
	self.show()



func _on_quick_text_timer_timeout():
	if not is_in_dialoge:
		$Label.text = "TextEnds"
		self.hide()
		
