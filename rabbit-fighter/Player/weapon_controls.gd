extends Node

@onready var play_char = $".."
@onready var weapon1 = $StateMachine_Weapon/Weapon_Pistol
@onready var weapon2 = $StateMachine_Weapon/Weapon_Ak47
@onready var weapon3 = $StateMachine_Weapon/Weapon_Knife
@onready var weapon4 = $StateMachine_Weapon/Weapon_Punch
@onready var finish = $StateMachine_Weapon/Weapon_Finish
@onready var weapon_list : Array = [weapon1 , weapon2, weapon3, weapon4, finish]
var current_weapon : Object


var level = 0

func _process(_delta: float) -> void:
	current_weapon = weapon_list[level]

	levelchkr()

func levelchkr():
	if play_char.player_id == 1:
		level = Global.level_p1
	elif  play_char.player_id == 2:
		level = Global.level_p2
