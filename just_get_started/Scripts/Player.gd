extends CharacterBody2D


@export var SPEED := 100.0
@export var moveable := true
var direction := Vector2()
var lastDirection := Vector2()
var orientation := Vector2(0, 1)

var isDashing = false
var justDashed = false
var canDash = true

var attackDirection := Vector2()

var isAttacking = false
var justAttacked = false
var alternativeAttack = false

func _physics_process(delta: float) -> void:
	direction = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()
	
	if !isAttacking and !isDashing:
		Orientation()
		if moveable: Move()
		
	justDashed = false
	if Input.is_action_just_pressed("Dash") and canDash:
		Dash()
	if $DashTimer.is_stopped():
		if isDashing == true:
			justDashed = true
		isDashing = false
	if justDashed:
		$DashCooldown.start()
	if $DashCooldown.is_stopped() and !isDashing:
		canDash = true
	
	attackDirection = Vector2(0, 0)
	if Input.is_action_just_pressed("Attack Down"):
		attackDirection = Vector2(0, 1)
	if Input.is_action_just_pressed("Attack Up"):
		attackDirection = Vector2(0, -1)
	if Input.is_action_just_pressed("Attack Left"):
		attackDirection = Vector2(-1, 0)
	if Input.is_action_just_pressed("Attack Right"):
		attackDirection = Vector2(1, 0)
		
	justAttacked = false
	if attackDirection:
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
			if !isDashing:
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
					$AnimatedSprite2D.play("Dash Up")
				if orientation.y == 1:
					$AnimatedSprite2D.play("Dash Down")
				if orientation.x == -1:
					$AnimatedSprite2D.play("Dash Left")
				if orientation.x == 1:
					$AnimatedSprite2D.play("Dash Right")
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
			if attackDirection.y == -1:
				$AnimatedSprite2D.play("Attack2 Up")
			if attackDirection.y == 1:
				$AnimatedSprite2D.play("Attack2 Down")
			if attackDirection.x == -1:
				$AnimatedSprite2D.play("Attack2 Left")
			if attackDirection.x == 1:
				$AnimatedSprite2D.play("Attack2 Right")		
		else:
			if attackDirection.y == -1:
				$AnimatedSprite2D.play("Attack1 Up")
			if attackDirection.y == 1:
				$AnimatedSprite2D.play("Attack1 Down")
			if attackDirection.x == -1:
				$AnimatedSprite2D.play("Attack1 Left")
			if attackDirection.x == 1:
				$AnimatedSprite2D.play("Attack1 Right")
		
func Attack():
	pass
	
func Dash():
	isDashing = true
	canDash = false
	var newTransform = $".".position + direction * 100
	$DashTimer.start()
	var tween = create_tween()
	tween.tween_property($".", "position", newTransform, 0.15)
