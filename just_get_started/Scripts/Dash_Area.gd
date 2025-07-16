extends Area2D

@export_flags("Left", "Right", "Up", "Down") var dash = 0
@export var UnlocksDash = false
@onready var note = %Notes

func _on_body_entered(body: Node2D) -> void:
	if !Global.dashUnlocked and UnlocksDash:
		Global.dashUnlocked = true
		note.ShowNoteById(0)
	body.canDash = true
	if dash & (1 << 0): # Left
		body.dashDirections.append(Vector2.LEFT)
	if dash & (1 << 1): # Right
		body.dashDirections.append(Vector2.RIGHT)
	if dash & (1 << 2): # Up
		body.dashDirections.append(Vector2.UP)
	if dash & (1 << 3): # Down
		body.dashDirections.append(Vector2.DOWN)


func _on_body_exited(body: Node2D) -> void:
	body.canDash = false
	body.dashDirections.clear()
