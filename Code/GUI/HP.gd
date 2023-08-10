extends PanelContainer

const MAX_HP = Defaluts.MAX_HP
const HEART_TSCN = preload("res://Code/GUI/Heart.tscn")
var is_first_time = true
@onready var hearths: Array = $HBoxContainer.get_children()



func _ready():
	GameEvents.hp_changed.connect(_on_hp_changed)
	set_hp(Defaluts.STARTING_HP)

func set_health_bar():
	var number_of_hearts = round(MAX_HP / 2.0)
	for i in range(number_of_hearts):
		var heart_inst = HEART_TSCN.instantiate()
		heart_inst.set_name("Heart" + str(i + 1))
		hearths.append(heart_inst)
		$HBoxContainer.add_child(heart_inst)

func set_hp(hp):
	var hp_pool = hp
	for heart in hearths:
		if hp_pool == 0:
			heart.health = 0
		if hp_pool == 1:
			heart.health = 1
			hp_pool -= 1
		if hp_pool >= 2:
			heart.health = 2
			hp_pool -= 2

func _on_hp_changed(hp):
	set_hp(hp)
	if is_first_time:
		is_first_time = false
		show()
