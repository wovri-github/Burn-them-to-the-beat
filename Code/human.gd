extends Area2D

var _speed := 0

func init(speed):
	_speed = speed

func _process(delta):
	var move = _speed * delta
	self.position -= Vector2(move, 0)

func die():
	queue_free()
