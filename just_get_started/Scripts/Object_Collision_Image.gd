extends Node2D

@onready var node = $"."
@onready var player = %Player
@onready var image = $Image

func _input(event):
	if event is InputEventKey and event.pressed:
		node.visible = false
		player.moveable = true

func ShowImage(img: Texture2D):
	image.texture = img
	node.visible = true
