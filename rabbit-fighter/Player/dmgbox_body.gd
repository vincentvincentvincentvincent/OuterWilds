extends Area3D
@onready var play_char = $".."
var playeridhit :int


func _ready() -> void:
	playeridhit = play_char.player_id
	
func hit_body(set_dmg_body: int):
	if play_char.invincible == false:
		$"..".health -= set_dmg_body
