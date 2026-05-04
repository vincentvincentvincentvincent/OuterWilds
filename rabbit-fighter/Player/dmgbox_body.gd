extends Area3D
@onready var play_char = $".."

func hit_body(set_dmg_body: int):
	if play_char.invincible == false:
		$"..".health -= set_dmg_body
