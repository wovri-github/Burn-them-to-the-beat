extends TextureRect

const MAX_HEALTH = 2
var health = MAX_HEALTH

func _ready():
	texture.set_current_frame(health)
	

func decrease_hp():
	health -= 1
	if health < 0:
		print_debug("[Heart]: Decrease below possibility")
		health = 0
	texture.set_current_frame(health)
