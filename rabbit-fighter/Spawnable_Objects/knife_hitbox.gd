extends Area3D


var active: bool = true
@onready var animation: AnimationPlayer = $AnimationPlayer

@export var set_dmg_body: int = 10
@export var set_dmg_head: int = 50
var direction: Vector3
var speed: int = 700
var brange: int = 7
var playeridlocal = 1

func setup(pos:Vector3 , Dir:Vector3, id:int):
	playeridlocal = id
	position = pos + Dir * 16
	direction = Dir 

func _physics_process(_delta: float) -> void:
	if playeridlocal == 1:
		position = Global.gunpoint1

	if playeridlocal == 1:
		position = Global.gunpoint2

func _on_area_entered(area: Area3D) -> void:
	if active == true:
		if "hit_head" in area:
			area.hit_head(set_dmg_head)
			print("hit")
		elif "hit_body" in area:
			area.hit_body(set_dmg_body)
			print("hit")
