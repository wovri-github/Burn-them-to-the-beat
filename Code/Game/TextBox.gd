extends NinePatchRect

var dialoge: Dialogue
@onready var label = $Label


func show_text_immediatly(new_text: String):
	assert(dialoge == null, "Text in wrong time")
	$Label.text = new_text
	$QuickTextTimer.start()
	self.show()

func _on_quick_text_timer_timeout():
	if not get_parent().is_playing():
		$Label.text = "TextEnds"
		self.hide()
		
