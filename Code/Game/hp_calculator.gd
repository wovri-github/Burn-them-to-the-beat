extends Node

var hp = Defaluts.STARTING_HP


func lose_hp():
	hp -= 1
	if hp <= 0:
		hp = 0
		owner.emit_signal("game_over", false)
	GameEvents.emit_signal("hp_changed", hp)

func _on_fireing_humans_human_escaped():
	lose_hp()
