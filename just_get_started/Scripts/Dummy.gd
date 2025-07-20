extends CharacterBody2D

@export var armor = false
@export var canDie = false
@onready var hitCounter = 0

func Hit(id):
	$Attack.play()
	$AnimatedSprite2D.play("Idle")
	$AnimatedSprite2D.play("Hit")
	
	$AnimatedSprite2DArmor.play("Idle")
	$AnimatedSprite2DArmor.play("Hit")
	if canDie:
		hitCounter += 1
	
func _physics_process(delta: float) -> void:
	if armor:
		$AnimatedSprite2DArmor.visible = true
	else:
		$AnimatedSprite2DArmor.visible = false
	
	if hitCounter == 3 and !armor or hitCounter == 4:
		visible = false
	
	if $AnimatedSprite2D.animation == "Hit" and\
	   !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("Idle")
	
	if $AnimatedSprite2DArmor.animation == "Hit" and\
	   !$AnimatedSprite2DArmor.is_playing():
		$AnimatedSprite2DArmor.play("Idle")
