extends Area2D

@onready var player = $"../.."

func _on_body_entered(body: Node2D) -> void:
	if player.moveable:
		body.Hit(4)
