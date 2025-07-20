extends Node2D

@export_file var level = "res://Scenes/Test_Scene.tscn"

func _ready() -> void:
	Music.stream_paused = true
	Global.narratorTextBoxes.clear()
	Global.playerTextBoxes.clear()
	Global.dashUnlocked = false

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped() or Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file(level)


func _on_tree_exited() -> void:
	Music.stream_paused = false
