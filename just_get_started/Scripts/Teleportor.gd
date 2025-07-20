extends Node2D

@export var spawn = false
@export var active = false
@export_file var level = "res://Scenes/Test_Scene.tscn"
@export var player: Node2D
var inside: bool = false

var readyToTeleport: bool = false
var readyForLight: bool = false
var readyToEnd: bool = false
var readyToStart: bool = false
var start = false

func _ready() -> void:
	if spawn:
		player.position = position + $Position.position
		player.visible = false
		player.moveable = false
		$SpawnTimer.start
		$SpawnProtectionTimer.start
	

func _physics_process(delta: float) -> void:
	if active:
		Activate(1.0)
		
	if inside and active and $SpawnProtectionTimer.is_stopped():
		go_to_level()
		
	if readyToTeleport and $TeleportTimer.is_stopped() and $SpawnProtectionTimer.is_stopped():
		get_tree().change_scene_to_file(level)
	if spawn:
		Spawn()
		
func go_to_level():
	if Input.is_action_pressed("Interact") and active:
		$TeleportTimer.start()
		readyToTeleport = true
		player.moveable = false
		player.get_node("ButtonAnimation").visible = false
		var tween = create_tween()
		tween.tween_property(player, "position", position + $Position.position, .35)
	if readyToTeleport:
		if player.position == position + $Position.position:
			if !readyToEnd:
				$PhaseTimer.start()
			readyToEnd = true
			var tween = create_tween()
			tween.tween_property($LightPillar, "scale:x", 1, .25)
			
		#print($PhaseTimer.time_left)
		if readyToEnd and $PhaseTimer.is_stopped():
			$TeleportSound.play()
			var camera := player.get_node("Camera2D")  # Adjust path if needed
			player.remove_child(camera)
			$Position.add_child(camera)
			camera.owner = $Position  # So it shows up properly in the scene tree if needed
			player.queue_free()
			
			var tween = create_tween()
			tween.tween_property($LightPillar, "scale:x", 0, .25)
		
func Spawn():
	if !start and $SpawnTimer.is_stopped():
		$TeleportSound.play()
		var tween = create_tween()
		tween.tween_property($LightPillar, "scale:x", 1, .25)
		start = true
	
	if $LightPillar.scale.x >= .99 and !readyToStart:
		var tween2 = create_tween()
		tween2.tween_property($LightPillar, "scale:x", 0, .25)
		readyToStart = true
		player.visible = true
		player.moveable = true
		
	if $SpawnProtectionTimer.is_stopped():
		readyToStart = false
		spawn = false
		
		

func Activate(active: float):
	if abs($Lights.modulate.a - active) >= 0.01:
		var tween = create_tween()
		tween.tween_property($Lights, "modulate:a", active, 0.5)

func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	if active:
		body.get_node("ButtonAnimation").visible = true
		#Activate(1.0)
	inside = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.get_node("ButtonAnimation").visible = false
	#if active:
		#Activate(0.0)
	inside = false
	spawn = false
