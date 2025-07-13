extends Area2D

@export var lineID = 0
@onready var playerTextBox = %PlayerTextBox
@onready var player = %Player
var triggered = false

func _on_body_entered(body: Node2D) -> void:
	if triggered == false:
		player.moveable = false
		triggered = true;
		await playerTextBox.StartDialogueById(lineID)
