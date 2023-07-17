extends TileMap

enum LEVER{OFF, ON}
@onready var tileset = get_tileset()


func _ready():
	switch_lever(LEVER.OFF)
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		switch_lever(LEVER.ON)
		$LeverSwitchOff.start(Defaluts.FIRE_TIME_SEC)

func switch_lever(state):
	var lever_position = Vector2i(7,17)
	if state == LEVER.OFF:
		lever_position = Vector2i(7,17)
	set_pattern(2, lever_position, tileset.get_pattern(state))
	


func _on_lever_switch_off_timeout():
	switch_lever(LEVER.OFF)
