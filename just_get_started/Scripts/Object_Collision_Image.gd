extends Node2D

@onready var player = %Player
@onready var image = $Image

var area

func ReceiveArea(object: Area2D):
	area = object

func _input(event):
	if event is InputEventKey and event.pressed and area:
		visible = false
		player.moveable = true
		area.monitoring = true
		area = null

func ShowImage(img: Texture2D, obj: Area2D):
	image.texture = img
	visible = true
	ReceiveArea(obj)
