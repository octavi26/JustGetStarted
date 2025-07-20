extends Node2D


func _ready() -> void:
	Music.stop()
	CameraShake.stop()
	if MenuCreditsMusic.stream_paused:
		MenuCreditsMusic.stream_paused = false
