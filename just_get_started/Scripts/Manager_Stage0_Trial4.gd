extends Node


@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"

func _ready() -> void:
	if Global.playerPos == 5:
		teleportor1.spawn = false
		teleportor2.spawn = true
	if Global.playerPos == 3:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 4
