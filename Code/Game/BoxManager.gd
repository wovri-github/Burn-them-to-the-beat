extends Node2D

@onready var BoxL = $RandomBoxL
@onready var BoxR = $RandomBoxR

var selected_pack
var correct_number: int = -1



func _ready():
	GameEvents.new_boxes_number_picked.connect(_on_new_boxes_number_picked)
	GameEvents.new_pool_picked.connect(_on_new_pool_picked)
	GameEvents.factor_total_changed.connect(_on_factor_value_change)


func _on_factor_value_change(factor):
	if factor == 0:
		BoxL.hide()
		return
	if factor == 1:
		BoxL.show()
		BoxR.hide()
		return
	if factor == 2:
		BoxR.show()
		return


func _on_new_boxes_number_picked(left: int, right: int):
	BoxL.change_frame(left, correct_number)
	BoxR.change_frame(right, correct_number)


func _on_new_pool_picked(new_pool: Array):
	correct_number = new_pool[0]
	
