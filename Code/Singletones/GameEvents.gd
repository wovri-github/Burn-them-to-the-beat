extends Node


signal hit_made(is_correct: bool, is_left_side: bool)
signal beat(_song_position_in_beats: int, _measure: int, tempo: int)
signal scored(score)
signal hp_changed(hp)
signal new_factor_sum(factor_sum: int)
