extends Camera2D

@export var shake_strength := 5.0
@export var shake_duration := 0.3

var shake_time_left := 0.0
var original_offset := Vector2.ZERO

func _ready():
	original_offset = offset

func _process(delta):
	if shake_time_left > 0:
		shake_time_left -= delta
		offset = original_offset + Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)
	else:
		CameraShake.stop()
		offset = original_offset

func start_shake(duration := 0.3, strength := 5.0):
	shake_duration = duration
	shake_strength = strength
	shake_time_left = duration
