extends Control



const MAX_HEALTH = 2
var health = MAX_HEALTH:
	set(val):
		health = val
		set_hp(health)



func set_hp(value):
	$Texture.texture.set_current_frame(value)
	if value > 0:
		$Tremble.start()
