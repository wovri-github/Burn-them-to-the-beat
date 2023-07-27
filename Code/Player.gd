extends AnimatedSprite2D

@export var _is_attacking_right := false
@export var _is_attacking_left := false
const MAX_DANCES = 6
var is_blue = false:
	set(new):
		is_blue = new
		if is_blue == true:
			blue_name = "_blue"
		else:
			blue_name = ""
		change_color()
var blue_name = ""
var factor_sum: int
@onready var hop_buffer = $HopBuffer


func _ready():
	GameEvents.new_factor_sum.connect(_on_factor_value_change)

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
	self.set_animation("attack" + blue_name)
	self.play()


func hop():
	if not self.is_playing():
		self.set_animation("dance" + blue_name)
		self.set_frame(randi_range(0, MAX_DANCES))
		hop_buffer.start(0.12)

func change_color():
	if self.is_playing() and self.animation in ["attack", "attack_blue"]:
		self.attack()
	else:
		self.set_animation("default" + blue_name)

func _on_hop_buffer_timeout():
	if not self.is_playing():
		self.set_animation("default" + blue_name)


func _on_animation_finished():
	self.set_animation("default" + blue_name)

func _on_factor_value_change(value):
	factor_sum = value
	if factor_sum >= 11:
		is_blue = true
	elif is_blue:
		is_blue = false
