extends Node2D


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:y", -12520, 200)
	
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$"../Click".play()
		get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")
