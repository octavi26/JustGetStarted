extends Node2D

@onready var label = $Label
@onready var node = $"."
var waitingInput = false
var receivedInput = false

var dialogueLines = {
	0: [ 
		"Welcome here, traveler!",
		"You can move around using W, A, S, D keys."
	],
	1: [ 
		"This is a teleporter.",
		"You can use it to teleport to other levels.",
		"See you at the next stop!"
	],
	2: [ 
		"Welcome to another destination!",
		"The first level was pretty simple, wasn't it?",
		"Things will get more complicated now."
	]
}

func _input(event):
	if event is InputEventKey and event.pressed:
		if waitingInput:
			receivedInput = true

# Function to display text one character at a time
func TypeText(text: String, speed: float = 0.025) -> void:
	label.text = ""
	for i in text.length():
		label.text += text[i]
		await get_tree().create_timer(speed).timeout
		

func StartDialogueById(lineID):
	node.visible = true
	for line in dialogueLines[lineID]:
		await TypeText(line)
		waitingInput = true
		receivedInput = false
		while not receivedInput:
			await get_tree().process_frame
		waitingInput = false
	node.visible = false
	#aici il repornesti movement-ul
