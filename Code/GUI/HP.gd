extends PanelContainer

@onready var hearts = [$HBoxContainer/Heart1, $HBoxContainer/Heart2, $HBoxContainer/Heart3]

func decrease_hp():
	for i in range(hearts.size() -1, -1, -1):
		var heart = hearts[i]
		if heart.health <= 0:
			continue
		heart.decrease_hp()
		if i == 0 and heart.health == 0:
			get_tree().change_scene_to_file("res://Code/Menu/EndTable.tscn")
		break
