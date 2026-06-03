extends Node3D

@export var level: int = 1
@onready var videostreamp = $SubViewport/VideoStreamPlayer
@onready var play_char = $"../../PlayerCharacter"



var videos: Array = ["res://Gui/Videos/pistol(2).ogv","res://Gui/Videos/ak47.ogv",
"res://Gui/Videos/Knife.ogv","res://Gui/Videos/Fist.ogv","res://Gui/Videos/Crown.ogv", 
"res://Gui/Videos/Skull.ogv"]
var currentvid
var leastlvl


func _ready() -> void:
	videostreamp.stream = load(videos[0])
	videostreamp.play()
	
	blinklight()
func _physics_process(_delta: float) -> void:
	levelchkr()


	currentvid = videos[level]


	if level == leastlvl:
		pass
	else:
		videostreamp.stop()
		videostreamp.stream = load(currentvid)
		videostreamp.play()





func levelchkr():
	if play_char.player_id == 1:
		leastlvl = level
		level = Global.level_p1
	elif  play_char.player_id == 2:
		leastlvl = level
		level = Global.level_p2


func blinklight():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property($Gui/Sphere, "transparency", 1, 0.6)
	tween.tween_property($Gui/Sphere, "transparency", 0, 0.6)
