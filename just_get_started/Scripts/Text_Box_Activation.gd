extends Area2D

@export var lineID = 0
@onready var narrator = %Narrator
@onready var player = %Player
@onready var area = $"."

func _on_body_entered(body: Node2D) -> void:
	if lineID not in Global.narratorTextBoxes:
		player.moveable = false
		await narrator.StartDialogueById(lineID)
