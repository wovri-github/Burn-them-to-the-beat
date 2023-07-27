extends CanvasLayer



func _input(event):
	if event.is_action_pressed("ui_cancel"):
		change_pause_menu_state(not self.is_visible())



func change_pause_menu_state(is_on):
	get_tree().set_pause(is_on)
	if is_on:
		self.show()
	else:
		self.hide()
