extends Area3D



@onready var animation: AnimationPlayer = $AnimationPlayer

@export var set_dmg_body: int = 10
@export var set_dmg_head: int = 20
var direction: Vector3
var playeridlocal: int

func setup(_pos:Vector3 , _Dir:Vector3, id:int):
	playeridlocal = id


func _physics_process(_delta: float) -> void:
	if playeridlocal == 1:
		position = Global.gunpoint1

	if playeridlocal == 2:
		position = Global.gunpoint2

	$AnimationPlayer.play("Punch")

func _on_area_entered(area: Area3D) -> void:
	if area.name == "Dmgbox_head" or area.name == "Dmgbox_body":
		if !area.playeridhit == playeridlocal :
			if "hit_head" in area:
				area.hit_head(set_dmg_head)
				print("hit")
			elif "hit_body" in area:
				area.hit_body(set_dmg_body)
				print("hit")


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
