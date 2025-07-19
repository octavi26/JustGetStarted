extends Node

@onready var dummy1 = $"../WORLD/Dummy1"
@onready var dummy2 = $"../WORLD/Dummy2"

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"

func _ready() -> void:
	if Global.playerPos == 4:
		teleportor1.spawn = false
		teleportor2.spawn = true
	if Global.playerPos == 2:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 3
	
func _physics_process(delta: float) -> void:
	if Global.stage0Trial3Finish:
		teleportor2.active = true
		
	if dummy1.get_node("AnimatedSprite2D").animation == "Hit":
		Global.stage0Trial3Finish = true
	if dummy2.get_node("AnimatedSprite2D").animation == "Hit":
		Global.stage0Trial3Finish = true
