extends Area2D

@export var lineID = 0
@onready var narrator = %Narrator
var triggered = false

func _on_body_entered(body: Node2D) -> void:
	#aici opresti movement-ul
	if triggered == false:
		triggered = true;
		await narrator.StartDialogueById(lineID)
