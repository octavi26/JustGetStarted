extends CharacterBody2D

@export_file var level = "res://Scenes/Test_Scene.tscn"
var hitSounds = [
	preload("res://Assets/Sounds/monster-3.wav"),
	preload("res://Assets/Sounds/monster-4.wav"),
	preload("res://Assets/Sounds/monster-5.wav"),
	preload("res://Assets/Sounds/monster-6.wav")
]

func _ready() -> void:
	$HitFlash.play("HitFlash")
	$BossSpawn.play()

func _physics_process(delta: float) -> void:
	if $ColorRect.modulate.a == 1:
		get_tree().change_scene_to_file(level)

func Hit(id):
	var random_sound = hitSounds[randi() % hitSounds.size()]
	$BossHit.stream = random_sound
	$BossHit.play()
	if $ColorRect.modulate.a == 0:
		var tween = create_tween()
		tween.tween_property($ColorRect, "modulate:a", 1, 2)
	if is_instance_valid($Horror2):
		$Horror2.queue_free()
	$HitFlash.play("HitFlash")
	CameraShake.play(8)
	$"../Camera2D".start_shake(3, 3)
