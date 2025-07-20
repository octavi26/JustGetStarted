extends Node2D

var active = false
var selected = 0

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$Click.play()
		%Player.moveable = true
		active = !active
		
	if !active:
		modulate.a = 0
		
	if active:
		%Player.moveable = false
		modulate.a = 1
		
	if active:
		if Input.is_action_just_pressed("ui_down"):
			$Click.play()
			selected += 1
		if Input.is_action_just_pressed("ui_up"):
			$Click.play()
			selected -= 1
		selected = (selected+3) % 3
		
		for i in range(3):
			if i == selected:
				get_child(i).frame = 1
			else:
				get_child(i).frame = 0
				
		if Input.is_action_just_pressed("ui_accept"):
			$Click.play()
			if selected == 0:
				%Player.moveable = true
				active = false
			if selected == 1:
				%Player.moveable = true
				Global.narratorTextBoxes = []
				get_tree().reload_current_scene()
			if selected == 2:
				%Player.moveable = true
				get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")
	
