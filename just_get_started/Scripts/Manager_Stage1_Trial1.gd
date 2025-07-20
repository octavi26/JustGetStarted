extends Node

@onready var teleportor2 = $"../Teleportor2"

func _ready() -> void:
	CameraShake.stop()
	Music.play()
	Global.wasInStage1 = true
	if Global.playerPos == 2:
		teleportor2.spawn = true
	if Global.playerPos == 0:
		teleportor2.spawn = false
	Global.playerPos = 1
