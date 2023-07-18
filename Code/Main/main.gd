extends Node


func init(lvl_mode):
	match lvl_mode:
		Defaluts.MODE.STORY:
			pass
		Defaluts.LVL.HARD:
			$Game/HitGoblinManager.queue_free()
			$Game/Story.queue_free()
			
