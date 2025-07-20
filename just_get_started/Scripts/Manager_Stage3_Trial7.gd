extends Node

func _ready() -> void:
	Global.playerVisitCount = 0
	var tween = create_tween()
	tween.tween_property($WhiteScreen, "modulate:a", 0, 2)
	
func _physics_process(delta: float) -> void:
	%Player.moveable = false
	if Input.is_action_just_pressed("Attack Down") or\
	   Input.is_action_just_pressed("Attack Up") or\
	   Input.is_action_just_pressed("Attack Left") or\
	   Input.is_action_just_pressed("Attack Right"):
		%Player.moveable = true
	if $Timer.is_stopped():
		$"../Area2D".monitoring = true
