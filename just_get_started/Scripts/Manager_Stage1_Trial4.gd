extends Node

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"
@onready var puzzle = $"../Puzzle"
@onready var camera = %Player.get_node("Camera2D")
@onready var doorLocked = $"../WORLD/DoorLocked"
@onready var doorUnlocked = $"../WORLD/DoorUnlocked"
@onready var textBox = %PlayerTextBox
@onready var player = %Player

func _ready() -> void:
	if Global.playerPos == 5:
		teleportor1.spawn = false
		teleportor2.spawn = true
	if Global.playerPos == 3:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 4
	if Global.stage1Trial4Door:
		doorLocked.queue_free()
		doorUnlocked.visible = true
	if Global.stage1Trial2FinishPuzzle:
		Global.stage1Trial4Back = true
		teleportor1.active = true
	
func _physics_process(delta: float) -> void:
	if puzzle.Code:
		if !Global.stage1Trial4Finish:
			CameraShake()
		Global.stage1Trial4Finish = true

	if Global.stage1Trial4Finish:
		teleportor2.level = puzzle.level


func CameraShake():
	camera.start_shake(0.5, 4.5)
	await get_tree().create_timer(0.8).timeout
	player.moveable = false
	textBox.StartDialogueById(6)
