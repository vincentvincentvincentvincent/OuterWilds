extends State

class_name Pistol

var state_name : String = "Pistol"

var play_char : CharacterBody3D
@onready var gun_pos: Node3D  = $"../../../Model/Gun_Point"
@onready var weapon_holder =  $"../.."

var active:bool

var Fire_time = 0.05
var bullet_scene  = "res://Spawnable_Objects/bulltet_pistol.tscn"
var Reload_time = 0.5
var clip_size_local: float = 10
var Recoil_Count: float = 0
var Recoil_Current: Vector3 
var recoil_pos: Array = [Vector3(0.733,0.649,0.0), Vector3(0.733,1.3,0.0), Vector3(0.733,0.453,0.0)] 
var recoil_rot: Array = [Vector3(0,0,0), Vector3(0,1,0), Vector3(0,-0.5,0 )] 
var shootingheld: bool = false




func _process(_delta: float) -> void:
	if weapon_holder.current_weapon == $"." and active== false:
		active = true
	if !weapon_holder.current_weapon == $"." and active== true:
		active = false

	if active == true:
		Global.Fire_time = Fire_time
		Global.bullet_scene = bullet_scene
		Global.Reload_time = Reload_time
		Global.Clip_size = clip_size_local
		
		Recoil_Current = recoil_pos[Recoil_Count]
		gun_pos.position = Recoil_Current
		gun_pos.rotation_degrees = recoil_rot[Recoil_Count]
		recoilreset()




func _on_player_character_attackheld() -> void:
	if Recoil_Count == 2:
		Recoil_Count = 0
	else :
		Recoil_Count +=1
		


func recoilreset():
	if shootingheld == false:
		Recoil_Count =0
	if Input.is_action_pressed("play_char_attack_action"):
		shootingheld = true
	elif  Input.is_action_just_released("play_char_attack_action"):
		shootingheld = false
