extends Node2D

@export var text1 = "Now that you finished the Tutorial, it's time for you to . . ."
@export var text2 = "Just Get Started!"

var timer1: bool = false
var timer2: bool = false
var timer3: bool = false

func _physics_process(delta: float) -> void:
	if $Timer1.is_stopped() and !timer1:
		timer1 = true
		visible = true
		TypeText(text2)
	if $Timer2.is_stopped() and !timer2:
		timer2 = true
		$"../Camera2D".start_shake(5, 15)
	if $Timer3.is_stopped() and !timer3:
		timer3 = true
		visible = false
	
	

func TypeText(text: String, speed: float = 0.025) -> void:
	$Label.text = ""
	for i in text.length():
		$Label.text += text[i]
		await get_tree().create_timer(speed).timeout
