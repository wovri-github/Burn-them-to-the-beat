extends Node

func _ready():
	init(Defaluts.LVL.EXTREME)

func init(lvl_difficulty):
	match lvl_difficulty:
		Defaluts.LVL.NORMAL:
			$Game/HitGoblinManager.queue_free()
			$Game/MusicBars.queue_free()
			$Game/Story.queue_free()
			$Game/DanceManager.queue_free()
			$UX/Factor.queue_free()
		Defaluts.LVL.HARD:
			$Game/HitGoblinManager.queue_free()
			$Game/Story.queue_free()
			
