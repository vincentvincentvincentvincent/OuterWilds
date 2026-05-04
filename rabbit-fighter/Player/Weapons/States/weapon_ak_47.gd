extends State

class_name Ak47

var state_name : String = "Ak47"

@onready var gun_pos: Node3D  = $"../../../Model/Gun_Point"
@onready var weapon_holder =  $"../.."
@onready var play_char : CharacterBody3D = $"../../.."

var active:bool = false



var Fire_time = 0.01
@onready var bullet_sceneL :String = "res://Spawnable_Objects/bulltet_ak47.tscn"
var Reload_time = 5
var clip_size_local: int = 12
var Recoil_Count: float = 0
var Recoil_Current: Vector3 
var recoil_pos: Array = [Vector3(0.733,0.649,0.0), Vector3(0.733,1,0.0), Vector3(0.733,1.3,0.0) , Vector3(0.733,1.2,0.0)
, Vector3(0.733,1.4,0.0) , Vector3(0.733,1.1,0.0) , Vector3(0.733,1.3,0.0) , Vector3(0.733,1.4,0.0)
, Vector3(0.733,1.2,0.0) , Vector3(0.733,1.3,0.0) , Vector3(0.733,1.2,0.0) , Vector3(0.733,1.2,0.0) , Vector3(0.733,1.4,0.0)] 
var recoil_rot: Array = [Vector3(0,0,0), Vector3(0,1,0), Vector3(0, 1,0 ) , Vector3(0, 1.1,0 )
, Vector3(0, 1,0 ) , Vector3(0, 1.1,0 ) , Vector3(0, 1.1,0 ), Vector3(0, 1,0 )
, Vector3(0, 1.1,0 ) , Vector3(0, 1.1,0 ) , Vector3(0, 1.0,0 ) , Vector3(0, 1.1,0 ), Vector3(0, 1.1,0 ) ] 
var shootingheld: bool = false




func _process(_delta: float) -> void:
	if weapon_holder.current_weapon == $"." and active== false:
		active = true

	if !weapon_holder.current_weapon == $"." and active== true:
		active = false


	if active == true: 
		play_char.Fire_time_p = Fire_time
		play_char.Reload_time_p = Reload_time
		play_char.Clip_size_p = clip_size_local
		
		if play_char.player_id == 1:
			Global.bullet_scene = bullet_sceneL
		elif play_char.player_id == 2:
			Global.bullet_scene2 = bullet_sceneL

		Recoil_Current = recoil_pos[Recoil_Count]
		gun_pos.position = Recoil_Current
		gun_pos.rotation_degrees = recoil_rot[Recoil_Count]
		recoilreset()




func _on_player_character_attackheld() -> void:
	if Recoil_Count == 12 and active== true:
		Recoil_Count = 0
	elif  active== true :
		Recoil_Count +=1
		


func recoilreset() :
	if shootingheld == false and active== true:
		Recoil_Count =0
	if Input.is_action_pressed("play_char_attack_action_%s" %[play_char.player_id]) and active== true:
		shootingheld = true
	elif  Input.is_action_just_released("play_char_attack_action_%s" %[play_char.player_id]) and active== true:
		shootingheld = false
