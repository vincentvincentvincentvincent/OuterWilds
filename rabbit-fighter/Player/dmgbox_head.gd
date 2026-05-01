extends Area3D

@onready var play_char = $".."
@onready var player_id = play_char.player_id
func hit_head(set_dmg_head: int):
	$"..".health -= set_dmg_head
	Input.action_press("play_char_stun_action_%s" %[player_id])
