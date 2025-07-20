extends CharacterBody2D


@export var active = false
var hits = 0
@export_file var level = "res://Scenes/Test_Scene.tscn"

func _physics_process(delta: float) -> void:
	visible = active
	$AnimatedSprite2D.frame = hits
	
	if hits > 7 and $ColorRect.modulate.a == 0:
		$Timer.start()
		var tween = create_tween()
		tween.tween_property($ColorRect, "modulate:a", 1.0, 1)
		
	if $Timer.is_stopped() and $ColorRect.modulate.a != 0:
		Global.playerVisitCount = 0
		get_tree().change_scene_to_file(level)
		
	
func Hit(id):
	if active: hits += 1
	$"../WORLD/Player/Camera2D".start_shake(3, 1)
