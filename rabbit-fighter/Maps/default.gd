extends Node3D

@onready var Spawnpointslocal : Array = [$"Spawn Points/Spawn1", $"Spawn Points/Spawn2", $"Spawn Points/Spawn3"]
@onready var bullet_scene: PackedScene 
@onready var bullet_scene2: PackedScene
func _on_player_character_attacked(pos: Vector3, Dir: Vector3, id) -> void:

	var attack = bullet_scene.instantiate() as Area3D
	$Bullets.add_child(attack)
	attack.setup(pos, Dir) 
	print(str(id))


func _process(_delta: float) -> void:

	bullet_scene = load(Global.bullet_scene)
	bullet_scene2 = load(Global.bullet_scene2)
	Global.Spawnpoints = Spawnpointslocal


func _on_player_character_2_attacked(pos: Vector3, dir: Vector3, id) -> void:
	var attack2 = bullet_scene2.instantiate() as Area3D
	$Bullets.add_child(attack2)
	attack2.setup(pos, dir) 
	print(str(id))
