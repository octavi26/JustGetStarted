extends Node2D

var Code = 0
@export_file var level = "res://Scenes/Test_Scene.tscn"

func _physics_process(delta: float) -> void:
	var col = $"Collisons/1"
	Code = col.active
