extends Area2D

@onready var player = %Player
@onready var narrator = %Narrator
@onready var doorLocked = $"../WORLD/DoorLocked"
@onready var doorUnlocked = $"../WORLD/DoorUnlocked"
@export var lineID = 0
var inside = false

func _physics_process(delta: float) -> void:
	if inside and Input.is_action_just_pressed("Interact"):
		if !Global.stage1Trial3Key:
			player.moveable = false
			monitoring = false
			narrator.StartDialogueById(lineID)
		else:
			OpenDoor()
	if !narrator.visible and !Global.stage1Trial3Key:
		Global.narratorTextBoxes.erase(lineID)
		monitoring = true

func _on_body_entered(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = true
	inside = true

func _on_body_exited(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = false
	inside = false
	
func OpenDoor():
	doorLocked.queue_free()
	doorUnlocked.visible = true
	queue_free()
	Global.stage1Trial4Door = true
