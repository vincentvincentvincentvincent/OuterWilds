extends Node

@onready var model: MeshInstance3D = %Model
@onready var state_machine_wpn: Node = %StateMachine_Weapon
@onready var play_char: PlayerCharacter = $".."
@onready var hud: CanvasLayer = %HUD
@onready var weapon1 = $StateMachine_Weapon/Weapon_Pistol
@onready var weapon2 = $StateMachine_Weapon/Weapon_Ak47
@onready var weapon_list : Array = [weapon1 , weapon2]
var current_weapon : Object
var level = 0

func _process(_delta: float) -> void:
	current_weapon = weapon_list[level]
