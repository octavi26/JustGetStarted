extends Node2D

var Code = 0
@export_file var level = "res://Scenes/Test_Scene.tscn"

func _physics_process(delta: float) -> void:
	var col = $"Collisons/1"
	Code = col.active
	var light = $Lights/Light1
	if light.modulate.a >= 0.99 and Code == false or\
		   light.modulate.a <= 0.01 and Code == true:
			Activate(light, int(Code))
			

func Activate(light, value):
	var tween = create_tween()
	tween.tween_property(light, "modulate:a", value, .25)
