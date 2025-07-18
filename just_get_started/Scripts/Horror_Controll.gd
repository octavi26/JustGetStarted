extends CharacterBody2D

@export_file var level = "res://Scenes/Test_Scene.tscn"

func _ready() -> void:
	$HitFlash.play("HitFlash")

func _physics_process(delta: float) -> void:
	if $ColorRect.modulate.a == 1:
		get_tree().change_scene_to_file(level)

func Hit(id):
	if $ColorRect.modulate.a == 0:
		var tween = create_tween()
		tween.tween_property($ColorRect, "modulate:a", 1, 2)
	if is_instance_valid($Horror2):
		$Horror2.queue_free()
	$HitFlash.play("HitFlash")
