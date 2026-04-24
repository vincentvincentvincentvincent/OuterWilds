extends Area3D

@onready var play_char = $".."

func hit_head(set_dmg_head: int):
	$"..".health -= set_dmg_head
	Input.action_press("play_char_stun_action")
