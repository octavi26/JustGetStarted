extends Node2D

var Code = [1, 1, 1]

func _physics_process(delta: float) -> void:
	for i in range(3):
		var col = $Collisons.get_child(i)
		Code[i] = col.active
	for i in range(3):
		var light = $Lights.get_child(i)
		if light.modulate.a >= 0.99 and Code[i] == false or\
		   light.modulate.a <= 0.01 and Code[i] == true:
			Activate(light, int(Code[i]))
	print(Code)
			

func Activate(light, value):
	var tween = create_tween()
	tween.tween_property(light, "modulate:a", value, .25)
