extends CSGBox3D

@export var id: int = 1



func _on_area_3d_area_entered(area: Area3D) -> void:
	use_collision = true
	
