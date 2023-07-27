@tool
extends Area2D

@export var flame_big_scale: float = 3
var no_one_burned = true
var is_blue = false
@onready var fires_sprites = $Sprites.get_children()



func _ready():
	GameEvents.new_factor_sum.connect(_on_new_factor_sum)
	for sprite in fires_sprites:
		sprite.set_scale(Vector2.ONE)
		sprite.play("fire")




func _input(event):
	if event.is_action_pressed("ui_accept"):
		big_flame()
		burn_human()


func big_flame():
	for sprite in fires_sprites:
		sprite.set_scale(Vector2(flame_big_scale, flame_big_scale))
	if not $FlameTimer.is_stopped():
		check_is_someone_burned()
	$FlameTimer.start()

func check_is_someone_burned():
	if no_one_burned:
		get_parent().emit_signal("flamed", false)
	no_one_burned = true

func burn_human():
	var humans_on_fire = self.get_overlapping_areas()
	if humans_on_fire:
		for human in humans_on_fire:
			human.die()
		no_one_burned = false
		get_parent().emit_signal("flamed", true)


func _on_new_factor_sum(factor_sum):
	if factor_sum >= 11:
		is_blue = true
		for sprite in fires_sprites:
			sprite.play("bluefire")
	elif is_blue == true:
		is_blue = false
		for sprite in fires_sprites:
			sprite.play("fire")
	

func _on_flame_timer_timeout():
	for sprite in fires_sprites:
		sprite.set_scale(Vector2.ONE)
	check_is_someone_burned()
