extends Node

@export var Code = [true, false, true, true, false]

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"
@onready var puzzle = $"../Puzzle"
@onready var camera = %Player.get_node("Camera2D")

func _ready() -> void:
	if Global.playerPos == 3:
		teleportor1.spawn = false
		teleportor2.spawn = true
	if Global.playerPos == 1:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 2
	
func _physics_process(delta: float) -> void:
	
	if Code == puzzle.Code:
		if Global.stage0Trial2Finish == false:
			CameraShake.play(8)
			camera.start_shake(0.5, 4.5)
		Global.stage0Trial2Finish = true
		
	if Global.stage0Trial2Finish:
		teleportor2.active = true
	
