extends Area3D

@onready var play_char = $".."
signal applystun

func hit_head(set_dmg_head: int):
	if play_char.invincible == false:
		$"..".health -= set_dmg_head
		applystun.emit()
