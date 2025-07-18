extends Node

func _ready() -> void:
	if Global.stage3Trial5Finish:
		%Reflexion.mirror = true
		$"../Mirror".active = true
		$"../Object".queue_free()
		$"../WORLD/Stone_Structure".queue_free()
		$"../WORLD/Grass2".visible = true
		$"../Teleportor2".active = false
		
	Global.stage3Trial5Finish = true
