extends Area2D

@export var lineID = 0
@onready var narrator = %Narrator
@onready var player = %Player
var triggered = false

func _on_body_entered(body: Node2D) -> void:
	if triggered == false:
		player.moveable = false
		triggered = true;
		await narrator.StartDialogueById(lineID)
