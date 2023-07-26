extends Node

signal new_boxes_number_picked(left: int, right: int)
signal new_pool_picked(new_pool: Array)

signal factor_total_changed(value: int)

signal action_made(action)


signal music_beat(beat: int)

signal setted_beat_multiplier(beat_multiplier: int)

signal hit_made(is_correct: bool, is_left_side: bool)
signal beat(_song_position_in_beats: int, _measure: int, tempo: int)
signal scored(score)
signal hp_changed(hp)
signal new_factor_sum(factor_sum: int)
