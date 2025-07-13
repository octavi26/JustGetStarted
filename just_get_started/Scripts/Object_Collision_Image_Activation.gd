extends Area2D

@export var image_shown: Texture2D
@onready var player = %Player
@onready var image = %Object_Image
var inside = false

func _physics_process(delta: float) -> void:
	if inside and Input.is_action_just_pressed("Interact"):
		player.moveable = false
		image.ShowImage(image_shown)

func _on_body_entered(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = true
	inside = true

func _on_body_exited(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = false
	inside = false
