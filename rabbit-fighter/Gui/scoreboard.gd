extends Node3D

@onready var animp = $Spin/AnimationPlayer
@export var scoreboardid: int
var play_char
var leastlvl
var level

var rolling2: bool = false
var rolling3: bool = false
var rolling4: bool = false
var rollinghash: bool = false



func _ready() -> void:
	if scoreboardid == 1:
		play_char = $"../../PlayerCharacter"
	elif  scoreboardid == 2:
		play_char = $"../../PlayerCharacter2"


func _process(_delta: float) -> void:
	lvlchkr()


	if leastlvl == 0 and level == 1 and rolling2 == false:
		rolling2 = true
		animp.stop()
		animp.play("Rollto2")
		await get_tree().create_timer(4).timeout
		animp.pause()
		
		
	if leastlvl == 1 and level == 2 and rolling3 == false:
		rolling3 = true
		animp.stop()
		animp.play("Rollto3")
		await get_tree().create_timer(4).timeout
		animp.pause()

	if leastlvl == 2 and level == 3 and rolling4 == false:
		rolling4 = true
		animp.stop()
		animp.play("Rollto4")
		await get_tree().create_timer(4).timeout
		animp.pause()

	if leastlvl == 3 and level == 4 and rollinghash == false:
		rolling4 = true
		animp.stop()
		animp.play("Rolltohash")
		await get_tree().create_timer(4).timeout
		animp.pause()








func lvlchkr():
	if play_char.player_id == 1:
		leastlvl = level
		level = Global.level_p1
	elif  play_char.player_id == 2:
		leastlvl = level
		level = Global.level_p2
