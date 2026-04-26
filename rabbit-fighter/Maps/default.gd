extends Node3D

var bullet_scene: PackedScene = load("res://Spawnable_Objects/bulltet_pistol.tscn")

func _on_player_character_attacked(pos: Vector3, Dir: Vector3) -> void:
	var attack = bullet_scene.instantiate() as Area3D
	$Bullets.add_child(attack)
	attack.setup(pos, Dir) 
	print("shot")
