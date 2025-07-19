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
	], "frame": [8] },
	1: { "text": [
		"What kind of hint is that?",
		"Is this guy dumb?"
	], "frame": [4] },
	2: { "text": [
		"These trees are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet."
	], "frame": [2] },
	3: { "text": [
		"Nothing here..."
	], "frame": [0] },
	4: { "text": [
		"Who does this narrator think he is?"
	], "frame": [3] },
	#nu schimba 6, e pt scrisul de dupa deblocarea usii
	6: { "text": [
		"Wait, I'm starting to remember",
		"I get it now. This is not a tutorial",
		"Not anymore"
	], "frame": [8, 8, 0] },
	10: { "text": [
		"Haven't I been here before already?",
		"What's happening?"
	], "frame": [0] },
	12: { "text": [
		"Pretty sure you've said that already..."
	], "frame": [0] },
	11: { "text": [
		"I remember doing this puzzle already. But it seems more complicated now",
		"I wonder what's up with this."
	], "frame": [4,0] },
	13: { "text": [
		"I am quite sure one of them had armour last time",
		"I should kill them this time just to make sure"
	], "frame": [0,7] },
	14: { "text": [
		"It feels like I used to know something, but i forgot what"
	], "frame": [6] },
	15: { "text": [
		"That's right, the Dash!",
		"How could I forget that?",
		"If only the portal back would work, I could get the key"
	], "frame": [1, 6, 0] },
	16: { "text": [
		"I feel like I need some sort of ability to get there"
	], "frame": [0] },
	17: { "text": [
		"you're acting weird..."
	], "frame": [4] },
	18: { "text": [
		"I am having a deja-vu"
	], "frame": [0] },
	19: { "text": [
		"That statue... I think that's new... It feels new"
	], "frame": [0] },
	20: { "text": [
		"Nothing written on this one"
	], "frame": [0] },
	21: { "text": [
		"All this happened already, I am certain of it",
		"This is where it all ends",
		"Or where all begins",
		"I don't know how to feel about what's about to happen..."
	], "frame": [0,0,0,6] },
	22: { "text": [
		"I am sure I knew this already"
	], "frame": [0] },
	100: { "text": [
		"Where am I?...",
		"Wait",
		"You're...",
		"I AM.",
		"YOU HAVE BROKEN MY SPELL. YOU HAVE ESCAPED MY TRAP.",
		"This was never a tutorial. It was you all along.",
		"It's you who I was tasked to slay!",
		"I AM THE GOD OF MISCHIEF. YOU...",
		"YOU SAW THROUGH MY LIES",
		"YOU HAVE BROKEN THE ILLUSION.",
		"All that nonsesne about getting started. How long have I been here?",
		"DECADES. YOU HAVE BEEN TRYING DECADES.",
		"YOU NEVER GAVE UP...",
		"YOUR WILL... IT HAS BEATEN ME",
		"It's time to put an end to this then.",
		"DO IT. SLAY ME. YOU HAVE EARNED IT."
	], "frame": [6,0,3,9,9,0,1,9,9,9,6,9,9,9,0,9] }
}
var dialogueTable2 = {
	0: { "text" : [
		"Wait...",
		"Haven't I been here before?"
	], "frame": [6] },
	1: { "text": [
		"I remember doing this puzzle already...",
		"But now it seems more complicated."
	], "frame": [0] },
	2: { "text": [
		"Didn't I beat these guys already?"
	], "frame": [4] },
	3: { "text": [
		"Why are these things repeating?"
	], "frame": [5] },
	4: { "text": [
		"These rocks are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet."
	], "frame": [1] },
	5: { "text": [
		"I hope I won't fall this time."
	], "frame": [4] },
	#nu schimba 6, e pt scrisul de dupa deblocarea usii
	6: { "text": [
		"Wait, I'm starting to remember",
		"I get it now. This is not a tutorial",
		"Not anymore"
	], "frame": [8, 8, 0] },
	17: { "text": [
		"But I didn't say anything this time!",
		"Something surely isn't right with you"
	], "frame": [3] },
	12: { "text": [
		"Just get it over with"
	], "frame": [4] },
	11: { "text": [
		"Why does the tutorial keep repeating? I've done this already"
	], "frame": [0] },
	13: { "text": [
		"If I go past this level, I can't get back to take the key unless the portal will open",
		"Also, where is that Narrator? he used to talk more."
	], "frame": [0] },
	14: { "text": [
		"This is where I onlock tha Dash, I remember now",
		"Let's hope the portal works and takes me back to the key"
	], "frame": [7] },
	15: { "text": [
		"I'm not sure of what's happening"
	], "frame": [0] },
	19: { "text": [
		"Maybe the secret code from the statue fits somewhere in the first levels!"
	], "frame": [1] },
	22: { "text": [
		"I miss the moments when you shut up"
	], "frame": [4] },
	21: { "text": [
		"Let's try again"
	], "frame": [0] }
}

var dialogueTable3 = {
	0: { "text" : [
		"Where am I33333?",
		"What is this weird place?"
	], "frame": [8] },
	1: { "text": [
		"What kind of hint is that?",
		"Is this guy dumb?"
	], "frame": [4] },
	2: { "text": [
		"These trees are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet"
	], "frame": [2] },
	3: { "text": [
		"Nothing here..."
	], "frame": [0] },
	4: { "text": [
		"Who does this narrator think he is?" 
	], "frame": [3] },
	
	#nu schimba 6, e pt scrisul de dupa deblocarea usii
	6: { "text": [
		"Wait, I'm starting to remember",
		"I get it now. This is not a tutorial",
		"Not anymore"
	], "frame": [8, 8, 0] },
	17: { "text": [
		"Hmm..."
	], "frame": [0] },
	12: { "text": [
		"Yeah Yeah..."
	], "frame": [0] },
	11: { "text": [
		"Let's try the code from the statue"
	], "frame": [0] },
	13: { "text": [
		"after I unlock the dash, I should get back here to take the key"
	], "frame": [0] },
	14: { "text": [
		"FInaly, I can get back after I get the Dash"
	], "frame": [4] }
}

var dialogueTableRandom = [
	{
		0: { "text" : [
			"Where am I?",
			"What is this weird place?"
		], "frame": [9] }
	},
	{
		0: { "text": [
			"What kind of hint is that?",
			"Is this guy dumb?"
		], "frame": [4] }
	},
	{
		1: { "text": [
			"These trees are indeed beautiful.",
			"I wonder if they made this or just stole it off the internet"
		], "frame": [2] }
	},
	{
		2: { "text": [
			"Nothing here..."
		], "frame": [0] }
	},
	{
		3: { "text": [
			"Who does this narrator think he is?" 
		], "frame": [3] }
	},
	{
		3: { "text": [
		"Why are these things repeating?"
		], "frame": [5] }
	},
	{
		4: { "text": [
		"These rocks are indeed beautiful.",
		"I wonder if they made this or just stole it off the internet."
		], "frame": [1] }
	},
	{
		5: { "text": [
		"I hope I won't fall this time."
		], "frame": [4] }
	},
	#nu schimba 6, e pt scrisul de dupa deblocarea usii
	{
		6: { "text": [
		"Weird, at least the portal is now open.."
		], "frame": [0] }
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
	skipText = false
	label.text = ""
	$Text.play()
	for i in text.length():
		label.text += text[i]
		if skipText:
			label.text = text
			break
		await get_tree().create_timer(speed).timeout
	$Text.stop()

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
	if lineID not in dialogueTable:
		player.moveable = true
		return
	visible = true
	var cnt = dialogueTable[lineID]["text"].size()
	var last = dialogueTable[lineID]["frame"].size() - 1
	for i in range(cnt):
		if i > last:
			$Image.frame = dialogueTable[lineID]["frame"][last]
		else:
			$Image.frame = dialogueTable[lineID]["frame"][i]
		await TypeText(dialogueTable[lineID]["text"][i])
		waitingInput = true
		receivedInput = false
		while not receivedInput:
			await get_tree().process_frame
		waitingInput = false
	visible = false
	Global.playerTextBoxes.append(lineID)
	player.moveable = true
