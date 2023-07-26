extends Node2D

const SHAKE_FORCE = 10
const SHAKE_REPEAT = 5
const SINGLE_SHAKE_SEC = 0.1
const SHAKE_FRAMES = {
	#"Walk": [4, 9],
	#"Attack": [8],
	"Roar": [5],
}
@onready var minotaur: AnimatedSprite2D = $Minotaur



func _ready():
	$AnimationPlayer.play("Intro")


func shake():
	var tween = get_tree().create_tween()
	for i in range(SHAKE_REPEAT):
		var random_x = randi_range(-SHAKE_FORCE, SHAKE_FORCE)
		var random_y = randi_range(0, SHAKE_FORCE)
		var random_shake_force = Vector2(random_x, random_y)
		tween.tween_property(self, "position", random_shake_force, SINGLE_SHAKE_SEC)
	self.position = Vector2.ZERO


func check_is_it_shake(animation_name: String, frame: int):
	if SHAKE_FRAMES.has(animation_name):
		if frame in SHAKE_FRAMES[animation_name]:
			shake()


func _on_minotaur_frame_changed():
	var animation_name: String = minotaur.get_animation()
	var frame: int = minotaur.get_frame()
	check_is_it_shake(animation_name, frame)
