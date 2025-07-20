extends Node2D

@onready var label = $Label
@onready var player = %Player
var waitingInput = false
var receivedInput = false
var skipText = false


var dialogueLines = {
	0: [ 
		"Welcome, traveler! DO NOT be afraid.",
		"You can move around using the following keys: W, A, S, D."
	],
	1: [
		"This is a teleporter.",
		"You can use it to travel between levels.",
		"See you at the next stop!"
	],
	2: [ 
		"This is a tutorial, in case you didn’t know already.",
		"I’ll teach you things, but you should already know how to solve puzzles.",
		"Hint: look around for clues."
	],
	3: [
		"I can hear you too, you know.",
		"Stop talking and do your part.",
		"You can light up one pillar at a time by pressing E.",
		"The teleporter will activate once the puzzle is solved."
	],
	4: [
		"You know how to solve puzzles... but do you know how to fight?",
		"Don’t worry — we’ll teach you."
	],
	5: [
		"Use the arrow keys to attack.",
		"Hit at least one dummy to activate the teleporter."
	],
	6: [
		"Nature is beautiful, isn’t it?",
		"At least look around — we spent time decorating this."
	],
	7: [
		"Climb the stairs. The next lesson awaits you up there."
	],
	8: [
		"So... You know how to walk, solve puzzles, and fight. What's missing?",
		"THE DASH!",
		"Press Space to dash to the other side."
	],
	9: [
		"Note: You can't dash just anywhere.",
		"You can only dash in certain designated areas."
	],
	10: [ 
		"Welcome to another destination!",
		"The first challenges were pretty simple, weren’t they?",
		"Things will get trickier from here on."
	],
	11: [
		"Now you’ll need to use everything you’ve learned so far.",
		"Think you can handle it?",
		"Hint: activate all the pillars."
	],
	12: [
		"Now it’s time for the combat section.",
		"Normal dummies have 3 HP. Armored ones have 4 HP.",
		"Eliminate them. NOW!"
	],
	13: [
		"This door is locked.",
		"MAYBE you should find a key?"
	],
	14: [
		"No you haven’t! Nothing’s happening yet!",
		"This is still the TUTORIAL, remember?",
		"Use W, A, S, D to move."
	],
	15: [
		"Hint: Try checking the sign!"
	],
	30: [
		"This is the Tutorial! Use W, A, S, D to move!"
	],
	35: [
		"Now it's time to solve some puzzles!"
	]
}


func _input(event):
	if event is InputEventKey and event.pressed and not event.echo and \
	event.keycode == KEY_ENTER:
		if waitingInput:
			receivedInput = true
		elif !skipText:
			skipText = true

# Function to display text one character at a time
func TypeText(text: String, speed: float = 0.025) -> void:
	skipText = false
	label.text = ""
	$Text.play(2.4)
	for i in text.length():
		label.text += text[i]
		if skipText:
			label.text = text
			break
		if is_instance_valid(get_tree()):
			await get_tree().create_timer(speed).timeout
	$Text.stop()

func StartDialogueById(lineID):
	visible = true
	for line in dialogueLines[lineID]:
		await TypeText(line)
		waitingInput = true
		receivedInput = false
		while not receivedInput:
			await get_tree().process_frame
		waitingInput = false
	visible = false
	Global.narratorTextBoxes.append(lineID)
	player.moveable = true
