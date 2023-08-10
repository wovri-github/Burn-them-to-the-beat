extends Control


const MAX_HEALTH = 2
var health = MAX_HEALTH:
	set(val):
		health = val
		set_hp(health)

func _ready():
	set_hp(MAX_HEALTH)

func set_hp(value):
	$Texture.frame = value
	if value > 0:
		$Tremble.start()
