extends Node2D

@onready var label = $Label
@onready var player = %Player
@onready var image = $Image
var waitingInput = false
var receivedInput = false
var skipText = false

var dialogueTable1 = {
	0: { "text" : [
		"Where am I?",
		"What is this weird place?"
	], "frame": 9 },
	1: { "text": [
		"What kind of hint is that?",
		"Is this guy dumb?"
	], "frame": 4 },
	2: { "text": [
		"These trees are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet."
	], "frame": 2 },
	3: { "text": [
		"Nothing here..."
	], "frame": 0 },
	4: { "text": [
		"Who does this narrator think he is?"
	], "frame": 3}
}
var dialogueTable2 = {
	0: { "text" : [
		"Wait...",
		"Haven't I been here before?"
	], "frame": 6 },
	1: { "text": [
		"I remember doing this puzzle already...",
		"But now it seems more complicated."
	], "frame": 0 },
	2: { "text": [
		"Didn't I beat these guys already?"
	], "frame": 4 },
	3: { "text": [
		"Still nothing here..."
	], "frame": 0 },
	4: { "text": [
		"These rocks are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet." 
	], "frame": 1},
	5: { "text": [
		"I hope I won't fall this time."
	], "frame": 4}
}
var dialogueTable3 = {
	0: { "text" : [
		"Where am I33333?",
		"What is this weird place?"
	], "frame": 9 },
	1: { "text": [
		"What kind of hint is that?",
		"Is this guy dumb?"
	], "frame": 4 },
	2: { "text": [
		"These trees are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet"
	], "frame": 2 },
	3: { "text": [
		"Nothing here..."
	], "frame": 0 },
	4: { "text": [
		"Who does this narrator think he is?" 
	], "frame": 3}
}
var dialogueTableRandom = [
	{
		0: { "text" : [
			"Where am I?",
			"What is this weird place?"
		], "frame": 9 }
	},
	{
		0: { "text": [
			"What kind of hint is that?",
			"Is this guy dumb?"
		], "frame": 4 }
	},
	{
		0: { "text": [
			"These trees are indeed beautiful.",
			"I wonder if they made this or just stole it off the internet"
		], "frame": 2 }
	},
	{
		2: { "text": [
			"Nothing here..."
		], "frame": 0 }
	},
	{
		3: { "text": [
			"Who does this narrator think he is?" 
		], "frame": 3 }
	}
]

func _ready() -> void:
	randomize()
	
func _input(event):
	if event is InputEventKey and event.pressed and not event.echo and \
	event.keycode == KEY_ENTER:
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
	var dialogueTable = dialogueTable1
	if Global.playerVisitCount > 0:
		if Global.playerVisitCount == 1:
			dialogueTable = dialogueTable2
		elif Global.playerVisitCount == 2:
			dialogueTable = dialogueTable3
		else:
			var candidates = []
			for dict in dialogueTableRandom:
				if dict.has(lineID):
					candidates.append(dict)
			dialogueTable = candidates[randi() % candidates.size()]
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
		skipText = false
	visible = false
	Global.playerTextBoxes.append(lineID)
	player.moveable = true
