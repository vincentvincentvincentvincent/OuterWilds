extends State

class_name Punch

var state_name : String = "Punch"

@onready var gun_pos: Node3D  = $"../../../Model/Gun_Point"
@onready var weapon_holder =  $"../.."
@onready var play_char : CharacterBody3D = $"../../.."
@onready var bullet_sceneL :String = "res://Spawnable_Objects/punch_hitbox.tscn"

var active:bool = false



var Fire_time = 0.05
var Reload_time = 3
var clip_size_local = 1


func _process(_delta: float) -> void:
	if weapon_holder.current_weapon == $"." and active== false:
		active = true


	if !weapon_holder.current_weapon == $"." and active== true:
		active = false


	if active == true:
		if play_char.player_id == 1:
			Global.bullet_scene = bullet_sceneL
		elif play_char.player_id == 2:
			Global.bullet_scene2 = bullet_sceneL

	if active == true: 
		play_char.Fire_time_p = Fire_time
		play_char.Reload_time_p = Reload_time
		play_char.Clip_size_p = clip_size_local
		gun_pos.position.y = -0.37
