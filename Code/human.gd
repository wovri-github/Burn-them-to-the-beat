extends Area2D

@export var random_spawn_range = 50
var _speed := 0

func init(speed, spawn_position):
	self.position = spawn_position
	$Sprite.frame = randi_range(0, 79)
	position.y += randi_range(-random_spawn_range, random_spawn_range)
	_speed = speed

func _physics_process(delta):
	var move = _speed * delta
	self.position.x -= move

func die():
	queue_free()
