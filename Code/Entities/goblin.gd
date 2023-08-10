extends AnimatedSprite2D

const MAX_DANCES = 6
@export var _is_attacking_right := false
@export var _is_attacking_left := false
@onready var hop_buffer = $HopBuffer


func _input(event):
	if event.is_action_pressed("ui_accept"):
		hop()
	if event.is_action_pressed("ui_left") \
			and _is_attacking_left:
		attack()
	if event.is_action_pressed("ui_right") \
			and _is_attacking_right:
		attack()


func attack():
	self.stop()
	self.play("attack")


func hop():
	if not self.is_playing():
		self.set_animation("dance")
		self.set_frame(randi_range(0, MAX_DANCES))
		hop_buffer.start(0.12)

func _on_hop_buffer_timeout():
	if not self.is_playing():
		self.set_animation("default")


func _on_animation_finished():
	self.set_animation("default")
 
