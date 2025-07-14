extends Area2D

@export var dashDirectionsFlags = []

func _on_body_entered(body: Node2D) -> void:
	body.canDash = true
	for flag in dashDirectionsFlags:
		match flag:
			"Left":
				body.dashDirections.append(Vector2.LEFT)
			"Right":
				body.dashDirections.append(Vector2.RIGHT)
			"Up":
				body.dashDirections.append(Vector2.UP)
			"Down":
				body.dashDirections.append(Vector2.DOWN)

func _on_body_exited(body: Node2D) -> void:
	body.canDash = false
	body.dashDirections.clear()
