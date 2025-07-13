extends Area2D

@export var active = false
var inside: bool = false

func _physics_process(delta: float) -> void:
	if inside and Input.is_action_just_pressed("Interact"):
		active = !active

func _on_body_entered(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = true
	inside = true

func _on_body_exited(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = false
	inside = false
