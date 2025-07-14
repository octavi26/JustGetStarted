extends Node2D

@export_file var level = "res://Scenes/Test_Scene.tscn"

func _ready() -> void:
	Global.playerVisitCount += 1

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped():
		get_tree().change_scene_to_file(level)
