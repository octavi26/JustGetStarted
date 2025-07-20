extends Node2D

@export var text1 = "Now that you finished the Tutorial, it's time for you to . . ."
@export var text2 = "Just Get Started!"

var timer1: bool = false
var timer2: bool = false
var timer3: bool = false
var timer4: bool = false
var timer5: bool = false
var timer6: bool = false
var timer7: bool = false
var timer8: bool = false
var timer9: bool = false
var timer10: bool = false
var timer11: bool = false
var timer12: bool = false

func _physics_process(delta: float) -> void:
	if $Timer1.is_stopped() and !timer1:
		timer1 = true
		visible = true
		TypeText(text1)
	if $Timer2.is_stopped() and !timer2:
		timer2 = true
		TypeText(text2)
	if $Timer3.is_stopped() and !timer3:
		timer3 = true
		visible = false
	if $Timer4.is_stopped() and !timer4:
		timer4 = true
		visible = true
		TypeText(text2)
	if $Timer5.is_stopped() and !timer5:
		timer5 = true
		CameraShake.play(8)
		$"../Camera2D".start_shake(.5, 3)
	if $Timer6.is_stopped() and !timer6:
		timer6 = true
		TypeText(text2)
	if $Timer7.is_stopped() and !timer7:
		timer7 = true
		CameraShake.play(8)
		$"../Camera2D".start_shake(.5, 5)
	if $Timer8.is_stopped() and !timer8:
		timer8 = true
		TypeText(text2)
	if $Timer9.is_stopped() and !timer9:
		timer9 = true
		CameraShake.play(8)
		$"../Camera2D".start_shake(.75, 7)
	if $Timer10.is_stopped() and !timer10:
		timer10 = true
		TypeText(text2)
	if $Timer11.is_stopped() and !timer11:
		timer11 = true
		CameraShake.play(8)
		$"../Camera2D".start_shake(5, 15)
	if $Timer12.is_stopped() and !timer12:
		timer12 = true
		visible = false
	
	

func TypeText(text: String, speed: float = 0.025) -> void:
	$Label.text = ""
	$Text.play(2.4)
	for i in text.length():
		$Label.text += text[i]
		if is_instance_valid(get_tree()):
			await get_tree().create_timer(speed).timeout
	$Text.stop()
