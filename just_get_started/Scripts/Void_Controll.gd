extends CharacterBody2D


@export var SPEED = 10.0
var direction := Vector2()

func _physics_process(delta: float) -> void:
	direction = Vector2(-Input.get_axis("Left", "Right"), -Input.get_axis("Up", "Down")).normalized()
	Move()

func Move():
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
