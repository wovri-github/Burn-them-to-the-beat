extends Node2D

var _already_dancing_goblins = []
var _prev_factor = 4
@onready var _dancing_goblins_pack = $DancingGoblins.get_children()
@onready var _dancing_goblin_god = $DancingGoblinGod



func _ready():
	GameEvents.new_factor_sum.connect(_on_factor_value_change)


func _on_factor_value_change(factor):
	manage_dancing_goblin(_prev_factor, factor)
	_prev_factor = factor


func manage_dancing_goblin(_prev_factor, factor):
	if factor == 11:
		_dancing_goblin_god.show()
	else:
		_dancing_goblin_god.hide()

	if _prev_factor < factor and factor >= 5:
		add_random_dancer()
	elif not _already_dancing_goblins.is_empty():
		hide_random_dancer()


func add_random_dancer():
	var new_dancer = _dancing_goblins_pack.pick_random()
	new_dancer.show()
	_dancing_goblins_pack.erase(new_dancer)
	_already_dancing_goblins.append(new_dancer)


func hide_random_dancer():
	var kick_dancer = _already_dancing_goblins.pick_random()
	kick_dancer.hide()
	_already_dancing_goblins.erase(kick_dancer)
	_dancing_goblins_pack.append(kick_dancer)
