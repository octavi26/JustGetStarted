extends Node2D

@onready var label = $Label
@onready var player = %Player
var waitingInput = false
var receivedInput = false
var skipText = false

var dialogueLines = {
	0: [ 
		"Welcome here, traveler! DO NOT be afraid.",
		"You can move around by using the following keys: W, A, S, D.",
		"Find the teleporter to advance."
	],
	1: [
		"This is a teleporter.",
		"You can use it to teleport to other levels.",
		"See you at the next stop!"
	],
	2: [ 
		"This is a tutorial if you didn't know already.",
		"I teach you things, but you should already know how to solve puzzles.",
		"Hint: look around for hints."
	],
	3: [
		"I can also hear you.",
		"Shut up and do your part of the job.",
 		"You can light up one pillar at a time by pressing E.",
		"The teleporter will activate after you solve the puzzle."
	],
	4: [
		"You know how to solve puzzles but do you know how to fight?",
		"Don't worry, we'll teach you that."
	],
	5: [
		"Use your arrow keys to attack.",
		"Hit at least one dummy to activate the teleporter."
	],
	6: [
		"The nature is beautiful, isn't it?",
		"At least try to look around, we spent some time decorating this."
	],
	7: [
		"Climb the stairs, the next lesson awaits you there."
	],
	8: [
		"So.....",
		"You know how to walk, do puzzles or fight.",
		"What is missing?",
		"THE DASH!",
		"Press space to dash to the other side."
	],
	9: [ 
		"Welcome to another destination!",
		"The first challenges were pretty simple, weren't they?",
		"Things will get more complicated now."
	],
	10: [
		"Now you need to use all the things you've learned.",
		"Can you do that?",
		"Hint: activate all pillars."
	],
	11: [
		"Now the fighting part.",
		"The normal dummies have 3HP, the armoured ones 4HP.",
		"Kill all of them. NOW!"
	]
}

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if waitingInput:
			receivedInput = true
		elif !skipText:
			skipText = true

# Function to display text one character at a time
func TypeText(text: String, speed: float = 0.025) -> void:
	label.text = ""
	for i in text.length():
		label.text += text[i]
		if skipText:
			label.text = text
			break
		await get_tree().create_timer(speed).timeout
		

func StartDialogueById(lineID):
	visible = true
	for line in dialogueLines[lineID]:
		await TypeText(line)
		waitingInput = true
		receivedInput = false
		while not receivedInput:
			await get_tree().process_frame
		waitingInput = false
		skipText = false
	visible = false
	Global.narratorTextBoxes.append(lineID)
	player.moveable = true
