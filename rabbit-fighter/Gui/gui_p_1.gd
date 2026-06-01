extends Node3D

@export var level: int = 1
@onready var videostreamp = $SubViewport/VideoStreamPlayer
@onready var videostreamb = $SubViewport2/VideoStreamPlayer
@onready var play_char = $"../../PlayerCharacter"



var videos: Array = ["res://Gui/Videos/pistol(2).ogv","res://Gui/Videos/ak47.ogv",
"res://Gui/Videos/Knife.ogv","res://Gui/Videos/Fist.ogv","res://Gui/Videos/Crown.ogv", 
"res://Gui/Videos/Skull.ogv"]
var currentvid
var leastlvl

var videosbar: Array = ["res://Gui/Videos/bar1.ogv","res://Gui/Videos/bars2.ogv","res://Gui/Videos/bars3.ogv",
"res://Gui/Videos/bars4.ogv", "res://Gui/Videos/bars5.ogv","res://Gui/Videos/bars6.ogv"]
var currentvideobar
var levelsbar
var lastlevelbar

func _ready() -> void:
	videostreamp.stream = load(videos[0])
	videostreamp.play()
	
	blinklight()
func _physics_process(_delta: float) -> void:
	levelchkr()
	lifechkr()
	if play_char.invincible == true:
		currentvid = videos[5]
		currentvideobar = videosbar[5]
	else:
		currentvid = videos[level]
		currentvideobar = videosbar[levelsbar]

	if level == leastlvl:
		pass
	else:
		videostreamp.stop()
		videostreamp.stream = load(currentvid)
		videostreamp.play()

	if levelsbar == lastlevelbar:
		pass
	else:
		print("888")
		videostreamb.stop()
		videostreamb.stream = load(currentvideobar)
		videostreamb.play()



func levelchkr():
	if play_char.player_id == 1:
		leastlvl = level
		level = Global.level_p1
	elif  play_char.player_id == 2:
		leastlvl = level
		level = Global.level_p2


func lifechkr():
	if play_char.health > 80:
		lastlevelbar = levelsbar
		levelsbar = 0
	elif play_char.health > 60 and play_char.health < 80:
		lastlevelbar = levelsbar
		levelsbar = 1
	elif play_char.health > 40 and play_char.health < 60:
		lastlevelbar = levelsbar
		levelsbar = 2
	elif play_char.health > 20 and play_char.health < 40:
		lastlevelbar = levelsbar
		levelsbar = 3
	elif play_char.health > 0 and play_char.health < 20:
		lastlevelbar = levelsbar
		levelsbar = 4
	elif play_char.health == 0:
		lastlevelbar = levelsbar
		levelsbar = 5

func blinklight():
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property($Gui/Sphere, "transparency", 1, 0.6)
	tween.tween_property($Gui/Sphere, "transparency", 0, 0.6)
