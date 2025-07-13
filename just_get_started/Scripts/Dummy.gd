extends CharacterBody2D

@export var armor = false

func Hit(id):
	$AnimatedSprite2D.play("Idle")
	$AnimatedSprite2D.play("Hit")
	
	$AnimatedSprite2DArmor.play("Idle")
	$AnimatedSprite2DArmor.play("Hit")
	
func _physics_process(delta: float) -> void:
	if armor:
		$AnimatedSprite2DArmor.visible = true
	else:
		$AnimatedSprite2DArmor.visible = false
		
	if $AnimatedSprite2D.animation == "Hit" and\
	   !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("Idle")
	
	if $AnimatedSprite2DArmor.animation == "Hit" and\
	   !$AnimatedSprite2DArmor.is_playing():
		$AnimatedSprite2DArmor.play("Idle")
