extends Node2D

var Code = [0, 0, 0]
var activated = -1

func _ready() -> void:
	if !Global.stage2Trial3Shard:
		for i in range(3):
			var col = $Collisons.get_child(i)
			col.monitoring = false

func _physics_process(delta: float) -> void:
	for i in range(3):
		var col = $Collisons.get_child(i)
		if !col.active and Code[i]:
			Code[i] = col.active 
		if col.active and !Code[i]:
			Code[i] = col.active
			activated = i
			for j in range(3):
				if j != activated:
					var coll = $Collisons.get_child(j)
					coll.active = false
					Code[j] = coll.active
			break
	for i in range(3):
		var light = $Lights.get_child(i)
		if light.modulate.a >= 0.99 and !Code[i] or\
		   light.modulate.a <= 0.01 and Code[i]:
			Activate(light, int(Code[i]))
			

func Activate(light, value):
	var tween = create_tween()
	tween.tween_property(light, "modulate:a", value, .25)
