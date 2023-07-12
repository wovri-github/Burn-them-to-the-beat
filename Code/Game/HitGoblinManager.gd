extends Node2D

@onready var GoblinsL = [$GoblinL, $GoblinL2]
@onready var GoblinsR = [$GoblinR, $GoblinR2]


func _ready():
	GameEvents.factor_total_changed.connect(_on_factor_value_change)

func _on_factor_value_change(factor):
	if factor == 0:
		return
	if factor == 1:
		GoblinsR[0].hide()
		return
	if factor == 2:
		GoblinsR[0].show()
		GoblinsR[1].hide()
		return
	if factor == 3:
		GoblinsR[1].show()
		GoblinsL[1].hide()
		return
	if factor == 4:
		GoblinsL[1].show()
		return
