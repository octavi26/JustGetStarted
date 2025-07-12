extends CharacterBody2D


@export var SPEED := 100.0
var direction := Vector2()
var lastDirection := Vector2()
var orientation := Vector2(0, 1)

var isAttacking = false
var justAttacked = false
var alternativeAttack = false

func _physics_process(delta: float) -> void:
	direction = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()
	
	if !isAttacking:
		Orientation()
		Move()
		
	justAttacked = false
	if Input.is_action_just_pressed("Attack"):
		isAttacking = true
		$AttackTimer.start()
		if alternativeAttack == false:
			alternativeAttack = true
		else:
			alternativeAttack = false
		Attack()
	if $AttackTimer.is_stopped():
		if isAttacking == true:
			justAttacked = true
		isAttacking = false
	if justAttacked:
		$AlterantiveAttackTimer.start()
	if $AlterantiveAttackTimer.is_stopped():
		alternativeAttack = false
		
	AnimationHandler()

func Move():
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func Orientation():	
	if direction:
		lastDirection = direction
	if Input.is_action_just_pressed("Down"):
		orientation = Vector2(0, 1)
	if Input.is_action_just_pressed("Up"):
		orientation = Vector2(0, -1)
	if Input.is_action_just_pressed("Left"):
		orientation = Vector2(-1, 0)
	if Input.is_action_just_pressed("Right"):
		orientation = Vector2(1, 0)
	if Input.is_action_just_released("Down") or \
	   Input.is_action_just_released("Up") or \
	   Input.is_action_just_released("Left") or \
	   Input.is_action_just_released("Right") and \
	   direction:
		orientation = direction
	if !orientation:
		orientation = lastDirection
	if justAttacked:
		orientation = direction
		if orientation.x and orientation.y:
			orientation = Vector2(sign(orientation.x), 0)

func AnimationHandler():
	if !isAttacking:
		if direction:
			if orientation.y == -1:
				$AnimatedSprite2D.play("Run Up")
			if orientation.y == 1:
				$AnimatedSprite2D.play("Run Down")
			if orientation.x == -1:
				$AnimatedSprite2D.play("Run Left")
			if orientation.x == 1:
				$AnimatedSprite2D.play("Run Right")
		else:
			if orientation.y == -1:
				$AnimatedSprite2D.play("Idle Up")
			if orientation.y == 1:
				$AnimatedSprite2D.play("Idle Down")
			if orientation.x == -1:
				$AnimatedSprite2D.play("Idle Left")
			if orientation.x == 1:
				$AnimatedSprite2D.play("Idle Right")
	else:
		if alternativeAttack:
			if orientation.y == -1:
				$AnimatedSprite2D.play("Attack2 Up")
			if orientation.y == 1:
				$AnimatedSprite2D.play("Attack2 Down")
			if orientation.x == -1:
				$AnimatedSprite2D.play("Attack2 Left")
			if orientation.x == 1:
				$AnimatedSprite2D.play("Attack2 Right")		
		else:
			if orientation.y == -1:
				$AnimatedSprite2D.play("Attack1 Up")
			if orientation.y == 1:
				$AnimatedSprite2D.play("Attack1 Down")
			if orientation.x == -1:
				$AnimatedSprite2D.play("Attack1 Left")
			if orientation.x == 1:
				$AnimatedSprite2D.play("Attack1 Right")
		
func Attack():
	pass
