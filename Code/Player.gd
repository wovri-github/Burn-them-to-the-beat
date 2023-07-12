extends AnimatedSprite2D

@export var _is_attacking_right := false
@export var _is_attacking_left := false
const MAX_DANCES = 6
var _factor_total: int
@onready var hop_buffer = $HopBuffer


func _ready():
	GameEvents.factor_total_changed.connect(_on_factor_total_changed)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		hop()
	if event.is_action_pressed("ui_left") \
			and _factor_total > 0 \
			and _is_attacking_left:
		attack()
	if event.is_action_pressed("ui_right") \
			and _factor_total > 0 \
			and _is_attacking_right:
		attack()


func attack():
	self.stop()
	self.set_animation("attack")
	self.play()


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

func _on_factor_total_changed(value):
	_factor_total = value
