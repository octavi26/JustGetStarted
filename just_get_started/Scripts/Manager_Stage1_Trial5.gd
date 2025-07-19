extends Node

@export var Code = [true, true, true]

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"
@onready var puzzle = $"../Puzzle"
@onready var camera = %Player.get_node("Camera2D")
@onready var dummy1 = $"../Dummy1"
@onready var dummy2 = $"../Dummy2"
@onready var dummy3 = $"../Dummy3"

func _ready() -> void:
	if Global.playerPos == 4:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 5
	if !Global.stage1Trial5Dummies:
		dummy1.visible = false
		dummy2.visible = false
		dummy3.visible = false
	if Global.stage1Trial2Puzzle:
		Global.stage1Trial4Back = true
		teleportor1.active = true
	
func _physics_process(delta: float) -> void:
	
	if Code == puzzle.Code:
		if Global.stage1Trial5Puzzle == false:
			camera.start_shake(0.5, 4.5)
		Global.stage1Trial5Puzzle = true
	
	if !dummy1.visible and !dummy2.visible and !dummy3.visible:
		Global.stage1Trial5Dummies = false
	
	if Global.stage1Trial5Puzzle:
		if !Global.stage1Trial5Dummies:
			Global.stage1Trial5Finish = true
	
	if Global.stage1Trial5Finish:
		teleportor2.active = true
		
	
