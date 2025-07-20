extends Node2D

@export_file var level = "res://Scenes/Test_Scene.tscn"

func _ready() -> void:
	Music.stream_paused = true
	if Global.wasInStage3:
		Global.playerVisitCount += 1
	else:
		Global.playerVisitCount = 0
	Global.narratorTextBoxes.clear()
	Global.playerTextBoxes.clear()
	Global.dashUnlocked = false

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped() or Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file(level)
