extends Node2D

var Code = [1, 0, 0, 0, 0]

func _physics_process(delta: float) -> void:
	for i in range(5):
		var col = $Collisons.get_child(i)
		Code[i] = col.active
	for i in range(5):
		var light = $Lights.get_child(i)
		if light.modulate.a >= 0.99 and Code[i] == false or\
		   light.modulate.a <= 0.01 and Code[i] == true:
			Activate(light, int(Code[i]))
			

func Activate(light, value):
	var tween = create_tween()
	tween.tween_property(light, "modulate:a", value, .25)
