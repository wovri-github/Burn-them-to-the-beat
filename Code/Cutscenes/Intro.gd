extends Node2D

const SHAKE_FRAMES = {
	#"Walk": [4, 9],
	#"Attack": [8],
	"Roar": [5],
}
var main_tscn = preload("res://Code/Main/main.tscn")
@onready var minotaur: AnimatedSprite2D = $Minotaur



func _ready():
	$AnimationPlayer.play("Intro")

func _unhandled_input(event):
	if event.is_action("ui_accept"):
		get_tree().change_scene_to_packed(main_tscn)


func check_is_it_shake(animation_name: String, frame: int):
	if SHAKE_FRAMES.has(animation_name):
		if frame in SHAKE_FRAMES[animation_name]:
			$ShakeC.shake()


func _on_minotaur_frame_changed():
	var animation_name: String = minotaur.get_animation()
	var frame: int = minotaur.get_frame()
	check_is_it_shake(animation_name, frame)
