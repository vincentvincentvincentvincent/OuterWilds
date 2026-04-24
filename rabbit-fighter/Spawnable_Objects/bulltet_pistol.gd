extends Area3D
@export var set_dmg_body: int = 20
@export var set_dmg_head: int = 40

var direction: Vector3
var speed: int = 10
var range: int = 13

func setup(pos:Vector3 , Dir:Vector3):
	position = pos + Dir * 16
	direction = Dir

func _ready() -> void:
	await get_tree().create_timer(range).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_area_entered(area: Area3D) -> void:
	if "hit_head" in area:
		area.hit_head(set_dmg_head)
	elif "hit_body" in area:
		area.hit_body(set_dmg_body)


	queue_free()
