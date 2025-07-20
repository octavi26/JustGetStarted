extends Node

@onready var teleportor2 = $"../Teleportor2"

func _ready() -> void:
	CameraShake.stop()
	Music.stream_paused = false
	Global.wasInStage1 = true
	if Global.playerPos == 2:
		teleportor2.spawn = true
	if Global.playerPos == 0:
		teleportor2.spawn = false
	Global.playerPos = 1
