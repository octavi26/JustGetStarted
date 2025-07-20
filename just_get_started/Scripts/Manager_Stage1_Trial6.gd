extends Node2D

@export_file var level = "res://Scenes/Test_Scene.tscn"

func _ready() -> void:
	Music.stream_paused = true
	if Global.wasInStage1:
		Global.playerVisitCount += 1
	Global.narratorTextBoxes.clear()
	Global.playerTextBoxes.clear()
	Global.dashUnlocked = false
	Global.stage1Trial3Dummies = true
	Global.stage1Trial5Dummies = true
	Global.stage1Trial3Finish = false
	Global.stage1Trial5Finish = false
	Global.stage1Trial5Puzzle = false

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped() or Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file(level)
