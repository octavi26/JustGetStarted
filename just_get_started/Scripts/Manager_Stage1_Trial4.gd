extends Node

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"
@onready var puzzle = $"../Puzzle"
@onready var camera = %Player.get_node("Camera2D")

func _ready() -> void:
	if Global.playerPos == 5:
		teleportor1.spawn = false
		teleportor2.spawn = true
	if Global.playerPos == 3:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 4
	
func _physics_process(delta: float) -> void:
	
	if puzzle.Code:
		if Global.stage1Trial4Finish == false:
			camera.start_shake(0.5, 4.5)
		Global.stage1Trial4Finish = true
		
	if Global.stage1Trial4Finish:
		teleportor2.active = true
