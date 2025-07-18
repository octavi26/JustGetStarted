extends Node2D


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:y", 1216, 40)
