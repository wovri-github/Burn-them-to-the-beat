extends Control

var actual_score: int = 0
const floating_difference_tscn = preload("res://Code/GUI/Score/score_difference.tscn")
var is_scored_first_time = true
@onready var score_label = %ScoreLabel
@onready var score_value_label = %ScoreValue
@onready var floating_container = $FloatingContainer
@onready var total_factor_label = %LabelTotal

func _ready():
	GameEvents.scored.connect(update_score)


func update_score(score):
	
	var color = Color.WHITE
	var difference = score - actual_score
	if difference > 0:
		color = Color.GREEN_YELLOW
		if is_scored_first_time:
			is_scored_first_time = false
			self.show()
	elif difference < 0:
		color = Color.FIREBRICK
	
	var floating_difference_inst = floating_difference_tscn.instantiate()
	var spawn_position = %FloatingScoreSpawn.global_position - floating_container.global_position
	floating_difference_inst.init(color, difference, spawn_position)
	floating_container.add_child(floating_difference_inst)
	
	score_value_label.text = str(score)
	change_color(color)
	$ColorTimer.start()
	actual_score = score

func change_color(color):
	score_label.modulate = color
	score_value_label.modulate = color

func _on_color_timer_timeout():
	change_color(Color.WHITE)


func total_factor_changed(total_factor):
	total_factor_label.text = "[x"+ str(total_factor) +"]"

func _on_test_pressed():
	update_score(1)
