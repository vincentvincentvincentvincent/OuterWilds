extends Node3D

@export var id: int = 1
@export var level: int = 1
@onready var videostreamb = $SubViewport2/VideoStreamPlayer
@onready var play_char = $"../../PlayerCharacter"

var videosbar: Array = ["res://Gui/Videos/bar1(1).ogv","res://Gui/Videos/bars2.ogv","res://Gui/Videos/bars3.ogv",
"res://Gui/Videos/bars4.ogv", "res://Gui/Videos/bars5.ogv","res://Gui/Videos/bars6.ogv"]
var currentvideobar
var levelsbar
var lastlevelbar

func _process(_delta: float) -> void:
	lifechkr()

	currentvideobar = videosbar[levelsbar]



	if levelsbar == lastlevelbar:
		pass
	else:
		videostreamb.stop()
		videostreamb.stream = load(currentvideobar)
		videostreamb.play()



func lifechkr():
	if play_char.health > 80:
		lastlevelbar = levelsbar
		levelsbar = 0
	elif play_char.health > 60:
		lastlevelbar = levelsbar
		levelsbar = 1
	elif play_char.health > 40 :
		lastlevelbar = levelsbar
		levelsbar = 2
	elif play_char.health > 20 :
		lastlevelbar = levelsbar
		levelsbar = 3
	elif play_char.health > 0 :
		lastlevelbar = levelsbar
		levelsbar = 4
	elif play_char.health == 0:
		lastlevelbar = levelsbar
		levelsbar = 5
