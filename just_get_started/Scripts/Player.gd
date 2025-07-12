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
		$AnimatedSprite2D.play("Idle Down")
		Attack()
		isAttacking = true
		$AttackTimer.start()
		if alternativeAttack == false:
			alternativeAttack = true
		else:
			alternativeAttack = false
	if isAttacking and $AttackTimer.is_stopped():
		isAttacking = false
		justAttacked = true
		$AnimatedSprite2D.play("Idle Down")
	if justAttacked:
		$AlterantiveAttackTimer.start()
	if $AlterantiveAttackTimer.is_stopped():
		alternativeAttack = false
	
	print($AnimatedSprite2D.animation, isAttacking)
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
	var action: String
	var dir: String
	var usedOrientation = orientation
	if isAttacking:
		usedOrientation = attackDirection
		if alternativeAttack: action = "Attack2"
		else: action = "Attack1"
	else:
		if !direction: action = "Idle"
		else:
			if isDashing: action = "Dash"
			else: action = "Run"
			
	if usedOrientation.x > 0:
		dir = "Right"
	if usedOrientation.x < 0:
		dir = "Left"
	if usedOrientation.y < 0:
		dir = "Up"
	if usedOrientation.y > 0:
		dir = "Down"
		
	$AnimatedSprite2D.play(action + " " + dir)
		
func Attack():
	pass
	
func Dash():
	isDashing = true
	canDash = false
	var newTransform = $".".position + direction * 100
	$DashTimer.start()
	var tween = create_tween()
	tween.tween_property($".", "position", newTransform, 0.15)
