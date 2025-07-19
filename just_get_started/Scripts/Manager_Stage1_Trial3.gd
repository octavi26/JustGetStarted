extends Node

@onready var dummy1 = $"../WORLD/Dummy1"
@onready var dummy2 = $"../WORLD/Dummy2"

@onready var key = $"../Key"

@onready var dashArea = $"../DashArea1"

@onready var teleportor1 = $"../Teleportor1"
@onready var teleportor2 = $"../Teleportor2"

func _ready() -> void:
	if Global.playerPos == 4:
		teleportor1.spawn = false
		teleportor2.spawn = true
	if Global.playerPos == 2:
		teleportor1.spawn = true
		teleportor2.spawn = false
	Global.playerPos = 3
	if !Global.stage1Trial3Dummies:
		dummy1.visible = false
		dummy2.visible = false
	if Global.stage1Trial3Key:
		key.queue_free()
	if Global.dashUnlocked:
		dashArea.monitoring = true
	
func _physics_process(delta: float) -> void:
	if !dummy1.visible and !dummy2.visible:
		Global.stage1Trial3Finish = true
		Global.stage1Trial3Dummies = false
	
	if Global.stage1Trial3Finish:
		teleportor2.active = true
