extends Control

@onready var bars = [$Bar1, $Bar2]
@onready var ground = $Ground.get_children()
@onready var max_value = bars[0].max_value


func grow_bars():
	for Bar in bars:
		var rand = randi_range(1, max_value)
		Bar.set_value(rand)
	await get_tree().create_timer(0.2).timeout
	for Bar in bars:
		Bar.set_value(0)

func make_color(color):
	for Bar in bars:
		Bar.set_modulate(color)
	for grd in ground:
		grd.set_modulate(color)
	await get_tree().create_timer(0.15).timeout
	for Bar in bars:
		Bar.set_modulate(Color.WHITE)
	for grd in ground:
		grd.set_modulate(Color.WHITE)


