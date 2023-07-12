extends Node


func _ready():
	GameEvents.beat.connect(_on_beat)

