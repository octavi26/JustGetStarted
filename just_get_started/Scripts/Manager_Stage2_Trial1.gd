extends Node

@onready var teleportor2 = $"../Teleportor2"
@onready var puzzle = $"../Puzzle"
@onready var camera = %Player.get_node("Camera2D")
@onready var textBox = %Narrator
@onready var player = %Player
var Code = [true, true, true]

func _ready() -> void:
	if Global.playerPos == 2:
		teleportor2.spawn = true
	if Global.playerPos == 0:
		teleportor2.spawn = false
	Global.playerPos = 1

func _physics_process(delta: float) -> void:
	if Global.stage2Trial3Shard and !Global.stage2Trial1Puzzle:
		if Global.stage2Trial3Shard == "blue":
			Code = [true, false, false]
		elif Global.stage2Trial3Shard == "yellow":
			Code = [false, true, false]
		else:
			Code = [false, false, true]
		if Code == puzzle.Code:
			Camera_Shake()
			Global.narratorTextBoxes.erase(14)
			Global.stage2Trial1Puzzle = true
	
func Camera_Shake():
	CameraShake.play(8)
	camera.start_shake(0.5, 4.5)
	await get_tree().create_timer(0.8).timeout
	player.moveable = false
	textBox.StartDialogueById(14)
