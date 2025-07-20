extends Node

func _ready() -> void:
	Global.playerVisitCount = 0
	var tween = create_tween()
	tween.tween_property($WhiteScreen, "modulate:a", 0, 2)
	
func _physics_process(delta: float) -> void:
	if $Timer.is_stopped():
		$"../Area2D".monitoring = true
