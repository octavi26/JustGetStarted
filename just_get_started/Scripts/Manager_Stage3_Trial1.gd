extends Node

func _ready() -> void:
	CameraShake.stop()
	if !Global.wasInStage3:
		Global.playerVisitCount = 0
	Global.wasInStage3 = true
