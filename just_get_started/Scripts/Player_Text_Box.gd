extends Node2D

@onready var label = $Label
@onready var player = %Player
@onready var image = $Image
var waitingInput = false
var receivedInput = false

var dialogueTable = {
	0: { "text" : [
		"Where am I?",
		"What is this weird place?"
	], "frame": 9 },
	1: { "text": [
		"Hello, traveler.",
		"Salut"
	], "frame": 1 },
	2: { "text": [
		"What brings you to this land?"
	], "frame": 2 },
	3: { "text": [
		"Ah, I see. Be careful out there."
	], "frame": 3 },
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
	$Image.frame = dialogueTable.get(lineID)["frame"]
	visible = true
	var line = dialogueTable.get(lineID)["text"]
	for text in line:
		await TypeText(text)
		waitingInput = true
		receivedInput = false
		while not receivedInput:
			await get_tree().process_frame
		waitingInput = false
	visible = false
	Global.playerTextBoxes.append(lineID)
	player.moveable = true
