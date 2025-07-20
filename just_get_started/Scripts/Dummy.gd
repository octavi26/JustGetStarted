extends CharacterBody2D

@export var armor = false
@export var canDie = false
var hitCounter = 0

func Hit(id):
	$Dummy.play()
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
		KillDummy()
	
	if $AnimatedSprite2D.animation == "Hit" and\
	   !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("Idle")
	
	if $AnimatedSprite2DArmor.animation == "Hit" and\
	   !$AnimatedSprite2DArmor.is_playing():
		$AnimatedSprite2DArmor.play("Idle")
		
func KillDummy():
	visible = false
	$CollisionShape2D.disabled = true
