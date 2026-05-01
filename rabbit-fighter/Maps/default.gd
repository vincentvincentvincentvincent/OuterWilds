extends Node3D


@onready var bullet_scene: PackedScene 

func _on_player_character_attacked(pos: Vector3, Dir: Vector3) -> void:
	var attack = bullet_scene.instantiate() as Area3D
	$Bullets.add_child(attack)
	attack.setup(pos, Dir) 
	print("shot")

func _process(delta: float) -> void:
	await get_tree().create_timer(1).timeout
	bullet_scene = load(Global.bullet_scene)
