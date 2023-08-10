extends Area2D

@export var flame_big_scale: float = 3
var is_blue = false
@onready var fires_sprites = $Sprites.get_children()


var current_areas: Array

var burn_difference = 0
var last_burn_time = 0



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
	$FlameTimer.start()


func burn_human():
	var humans_on_fire = current_areas # self.get_overlapping_areas()
	burn_difference = Time.get_ticks_msec()
	var burned_humans_count = 0
	if humans_on_fire:
		for human in humans_on_fire:
			burned_humans_count += 1
			human.die()
	get_parent().emit_signal("flamed", burned_humans_count)


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

var area_on_fire_msec = 0
var prev_area_on_fire_msec = 0

func _on_area_entered(area):
	#print("Entered: ", Time.get_ticks_msec())
	#print(prev_area_on_fire_msec-  area_on_fire_msec)
	prev_area_on_fire_msec = area_on_fire_msec
	area_on_fire_msec = Time.get_ticks_msec()
	current_areas.append(area)


func _on_area_exited(area):
	#print("Escaped: ", Time.get_ticks_usec())
	#print("Burn difference: ", burn_difference)
	current_areas.erase(area)
