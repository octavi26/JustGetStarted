extends Node

@onready var teleportor2 = $"../Teleportor2"

func _ready() -> void:
	if Global.playerPos == 2:
		teleportor2.spawn = true
	if Global.playerPos == 0:
		teleportor2.spawn = false
	Global.playerPos = 1
	MenuCreditsMusic.stream_paused = true
	Music.play()
