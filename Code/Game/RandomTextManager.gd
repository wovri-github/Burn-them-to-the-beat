extends Node

@export var random_happy_dialoges: Dialogue
@export var text_chance: float = 0.1
var current_beat = -99
@onready var max_texts = random_happy_dialoges.texts.size()
@onready var main_text_box = $"../MainTextBox"

func _ready():
	GameEvents.beat.connect(_on_beat)


func _on_fireing_humans_flamed(_is_human_burned):
	if not _is_human_burned:
		return
	if randf() > text_chance:
		return
	if not get_parent().is_playing():
		var random_text = random_happy_dialoges.texts[randi_range(0, max_texts - 1)]
		main_text_box.show_text_immediatly(random_text)

func _on_beat(_beat, measure, tempo):
	current_beat = _beat
