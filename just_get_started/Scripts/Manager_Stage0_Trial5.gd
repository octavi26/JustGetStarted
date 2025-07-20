extends Node

@export var Code = [true, true, true]

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"
@onready var puzzle = $"../Puzzle"
@onready var camera = %Player.get_node("Camera2D")
@onready var dummy1 = $"../WORLD/Dummy1"
@onready var dummy2 = $"../WORLD/Dummy2"
@onready var dummy3 = $"../WORLD/Dummy3"

func _ready() -> void:
	if Global.playerPos == 4:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 5
	
func _physics_process(delta: float) -> void:
	
	if Code == puzzle.Code:
		if Global.stage0Trial5Puzzle == false:
			CameraShake.play(8)
			camera.start_shake(0.5, 4.5)
		Global.stage0Trial5Puzzle = true
	
	if Global.stage0Trial5Puzzle:
		if !dummy1.visible and !dummy2.visible and !dummy3.visible:
			Global.stage0Trial5Finish = true
	
	if Global.stage0Trial5Finish:
		teleportor2.active = true
		
	
