extends Area3D

func hit_head(set_dmg_head: int):
	$"..".health -= set_dmg_head
