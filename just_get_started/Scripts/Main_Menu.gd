extends Node2D


var selected = 0
var scene = 0

func _ready() -> void:
	MenuCreditsMusic.play(2)

func _physics_process(delta: float) -> void:
	if scene == 0:
		print(selected)
		if Input.is_action_just_pressed("ui_down"):
			$Click.play()
			selected += 1
		if Input.is_action_just_pressed("ui_up"):
			selected -= 1
			$Click.play()
			
		selected = abs(selected) % 2
			
		if selected > -1:
			$Main/Button.frame = !selected
			$Main/Button2.frame = selected
		
		if Input.is_action_just_pressed("ui_accept"):
			$Click.play()
			if selected == 0:
				scene = 1
				var tween1 = create_tween()
				tween1.tween_property($Contract, "position", Vector2(0, 0), 1)
				var tween2 = create_tween()
				tween2.tween_property($Contract, "rotation", 0, 1)
				
				var tween3 = create_tween()
				tween3.tween_property($Main, "position", Vector2(0, -1000), 1)
				var tween4 = create_tween()
				tween4.tween_property($Main, "rotation", 3.14, 1)
				
				var tween5 = create_tween()
				tween5.tween_property($GameBy, "position", Vector2(2000, -1000), 1)
				var tween6 = create_tween()
				tween6.tween_property($GameBy, "rotation", 3.14, 1)
				
				var tween7 = create_tween()
				tween7.tween_property($Controls, "position", Vector2(-2000, 1000), 1)
				var tween8 = create_tween()
				tween8.tween_property($Controls, "rotation", -4.14, 1)
				
				var tween9 = create_tween()
				tween9.tween_property($Blank, "position", Vector2(-2000, 0), 1)
			elif selected == 1:
				get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
	else:
		if Input.is_action_just_pressed("ui_accept"):
			$Click.play()
			$Contract/Button.frame = 1
			$Timer.start()
			var tween = create_tween()
			tween.tween_property($BlackScreen, "modulate:a", 1, 2)
			
	if abs($BlackScreen.modulate.a - 1) <= 0.01 and $Timer.is_stopped():
		get_tree().change_scene_to_file("res://Scenes/Stage0_Trial1.tscn")
