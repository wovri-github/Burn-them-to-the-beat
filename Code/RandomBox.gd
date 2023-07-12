extends AnimatedSprite2D


func change_frame(new_frame: int, correct_number: int):
	set_frame(new_frame)
	if new_frame == correct_number:
		selection()
	else:
		deselect()

func selection():
	set_modulate(Color.GREEN)

func deselect():
	set_modulate(Color.WHITE)
