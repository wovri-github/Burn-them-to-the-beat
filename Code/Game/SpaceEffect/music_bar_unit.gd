extends Control

const DEFAULT_COLOR = Color.WHITE
var current_color: Color = Color.WHITE:
	set(new):
		current_color = new
		_make_color(current_color)
		if current_color != DEFAULT_COLOR:
			await get_tree().create_timer(0.15).timeout
			_reset_color()
var is_growth = false:
	set(new):
		is_growth = new
		if is_growth == true:
			_grow_bars()
			await get_tree().create_timer(0.2).timeout
			_reset_grow()
@onready var bars = [$Bar1, $Bar2]
@onready var ground = $Ground.get_children()
@onready var max_value = bars[0].max_value



func _grow_bars():
	for bar in bars:
		var rand = randi_range(1, max_value)
		bar.set_value(rand)

func _reset_grow():
	is_growth = false
	for bar in bars:
		bar.set_value(0)


func _make_color(color):
	for obj in (bars + ground):
		obj.set_modulate(color)

func _reset_color():
	current_color = DEFAULT_COLOR


