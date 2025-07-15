extends Area2D

@onready var sprite = $"../AnimatedSprite2D"
@onready var node = $".."

func _on_body_entered(body: Node2D) -> void:
	Global.stage1Key = true
	Pickup()

func Pickup():
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", sprite.position.y - 10, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	node.queue_free()
