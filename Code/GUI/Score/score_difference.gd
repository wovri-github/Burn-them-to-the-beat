extends Label

@export var position_x_offset = -164
@export var speed = 100


func init(color, difference, spawn_point):
	self.modulate = color
	self.position = spawn_point
	self.position.x += position_x_offset
	if difference > 0:
		difference = "+" + str(difference)
	self.text = "(" + str(difference) + ")"

func _process(delta):
	self.position.y -= speed * delta


func _on_life_time_timeout():
	queue_free()
