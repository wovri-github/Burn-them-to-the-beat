extends Area2D

@export var random_spawn_range = 50
var _speed: float = 0
var delta_speed = 0
var was_on_area = false
var start_time = 0

func init(speed, spawn_position):
	self.position = spawn_position
	$Sprite.frame = randi_range(0, 79)
	position.y += randi_range(-random_spawn_range, random_spawn_range)
	_speed = speed

func _ready():
	start_time = Time.get_ticks_usec()

func _process(delta):
	var move = _speed * delta
	delta_speed = move
	self.position.x -= move

func die():
	queue_free()


func _on_area_entered(area):
	#print(_speed - ((-self.position.x + 3039 + 550) / (Time.get_ticks_usec() - start_time) )* 1000000)
	was_on_area = true
