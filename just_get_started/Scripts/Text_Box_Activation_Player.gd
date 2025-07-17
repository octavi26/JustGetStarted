extends Area2D

@export var lineID = 0
@onready var playerTextBox = %PlayerTextBox
@onready var player = %Player

func _on_body_entered(body: Node2D) -> void:
	if lineID not in Global.playerTextBoxes:
		player.moveable = false
		await playerTextBox.StartDialogueById(lineID)
