extends Area3D

func hit_body(set_dmg_body: int):
	$"..".health -= set_dmg_body
