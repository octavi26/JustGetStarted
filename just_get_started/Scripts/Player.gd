extends CharacterBody2D

@export var SPEED := 100.0
@export var moveable := true
@onready var note = %Notes
var direction := Vector2()
var lastDirection := Vector2()
var orientation := Vector2(0, -1)

var isDashing = false
var justDashed = false
var canDash = false
#modified things
var dashDirections: Array[Vector2] = []
var dashZone = false

var attackDirection := Vector2()

var isAttacking = false
var justAttacked = false
var alternativeAttack = false
var firstFrameAttack = false

func _physics_process(delta: float) -> void:
	if moveable:
		direction = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down")).normalized()
	else:
		direction = Vector2(0, 0)
	
	if !isAttacking and !isDashing and moveable:
		Orientation()
		Move()
		
	justDashed = false
	#modified things
	if Input.is_action_just_pressed("Dash") and !dashZone and \
	Global.dashUnlocked:
		note.ShowNoteById(2)
	if Input.is_action_just_pressed("Dash") and dashZone and \
	!Global.dashUnlocked:
		note.ShowNoteById(1)
	var dash_input = Vector2(
	Input.get_action_strength("Right") - Input.get_action_strength("Left"),
	Input.get_action_strength("Down") - Input.get_action_strength("Up")).normalized()
	if Input.is_action_just_pressed("Dash") and canDash and \
	   moveable and !dashDirections.is_empty() and \
	dashZone and Global.dashUnlocked:
		if dash_input in dashDirections:
			direction = dash_input
			Dash()
		else:
			note.ShowNoteById(3)
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
	firstFrameAttack = false
	if attackDirection:
		firstFrameAttack = true
		$AnimatedSprite2D.play("Idle Up")
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
		$AnimatedSprite2D.play("Idle Up")
		$AttackCollision/Area2DDown/CollisionShape2D.disabled = true
		$AttackCollision/Area2DLeft/CollisionShape2D.disabled = true
		$AttackCollision/Area2DRight/CollisionShape2D.disabled = true
		$AttackCollision/Area2DUp/CollisionShape2D.disabled = true
	if !firstFrameAttack:
		$AttackCollision/Area2DDown/CollisionShape2D.disabled = true
		$AttackCollision/Area2DLeft/CollisionShape2D.disabled = true
		$AttackCollision/Area2DRight/CollisionShape2D.disabled = true
		$AttackCollision/Area2DUp/CollisionShape2D.disabled = true
	
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
	var action := "Idle"
	var dir := "Up"
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
	if usedOrientation.y > 0:
		dir = "Down"
	if usedOrientation.y < 0:
		dir = "Up"
		
	$AnimatedSprite2D.play(action + " " + dir)
		
func Attack():
	if attackDirection == Vector2(0, 1):
		$AttackCollision/Area2DDown/CollisionShape2D.disabled = false
		$AttackCollision/Area2DLeft/CollisionShape2D.disabled = true
		$AttackCollision/Area2DRight/CollisionShape2D.disabled = true
		$AttackCollision/Area2DUp/CollisionShape2D.disabled = true
	if attackDirection == Vector2(0, -1):
		$AttackCollision/Area2DDown/CollisionShape2D.disabled = true
		$AttackCollision/Area2DLeft/CollisionShape2D.disabled = true
		$AttackCollision/Area2DRight/CollisionShape2D.disabled = true
		$AttackCollision/Area2DUp/CollisionShape2D.disabled = false
	if attackDirection == Vector2(1, 0):
		$AttackCollision/Area2DDown/CollisionShape2D.disabled = true
		$AttackCollision/Area2DLeft/CollisionShape2D.disabled = true
		$AttackCollision/Area2DRight/CollisionShape2D.disabled = false
		$AttackCollision/Area2DUp/CollisionShape2D.disabled = true
	if attackDirection == Vector2(-1, 0):
		$AttackCollision/Area2DDown/CollisionShape2D.disabled = true
		$AttackCollision/Area2DLeft/CollisionShape2D.disabled = false
		$AttackCollision/Area2DRight/CollisionShape2D.disabled = true
		$AttackCollision/Area2DUp/CollisionShape2D.disabled = true
	
func Dash():
	isDashing = true
	canDash = false
	var newTransform = $".".position + direction * 100
	$DashTimer.start()
	var tween = create_tween()
	tween.tween_property($".", "position", newTransform, 0.15)
