extends State

class_name Pistol

var state_name : String = "Pistol"

var play_char : CharacterBody3D
@onready var weapon_holder =  $"../.."

var active:bool

var Fire_time = 0.5
var bullet_scene  = "res://Spawnable_Objects/bulltet_pistol.tscn"
var Reload_time = 1.8
var clip_size = 10
var Recoil_Count: int = 0
var Recoil_Current: Vector3 
var recoil_pos: Array = [Recoil1, Recoil2, Recoil3] 

@export_category("Recoil Positions")
@export var Recoil1 = Vector3(0.733,0.649,0.0)
@export var Recoil2 = Vector3(0.733,1.3,0.0)
@export var Recoil3 = Vector3(0.733,0.453,0.0)





func _process(_delta: float) -> void:
	if weapon_holder.current_weapon == $"." and active== false:
		active = true
	if !weapon_holder.current_weapon == $"." and active== true:
		active = false

	if active == true:
		Global.Fire_time = Fire_time
		Global.bullet_scene = bullet_scene
		Global.Reload_time = Reload_time

		$"../../../Model/Gun_Point".position = Recoil_Current
		if Input.is_action_just_pressed("play_char_attack_action") and $"../../..".can_attack == true:
			Recoil_Count += 1
		elif Input.is_action_just_pressed("play_char_attack_action") and $"../../..".can_attack == true and Recoil_Count == 2:
			Recoil_Count = 0
