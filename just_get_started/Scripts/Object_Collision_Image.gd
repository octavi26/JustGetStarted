extends Node2D

@onready var player = %Player
@onready var image = $Image
@onready var area

func ReceiveArea(object: Area2D):
	area = object

func _input(event):
	if event is InputEventKey and event.pressed:
		visible = false
		player.moveable = true
		if area:
			area.monitoring = true

func ShowImage(img: Texture2D, obj: Area2D):
	image.texture = img
	visible = true
	ReceiveArea(obj)
