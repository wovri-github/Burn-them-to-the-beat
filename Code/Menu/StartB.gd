extends Button

@export var on_hover_text = "BURN"
var default_text = get_text()




func _on_mouse_entered():
	set_text(on_hover_text)


func _on_mouse_exited():
	set_text(default_text)
