extends Node2D

@onready var label = $Label
@onready var player = %Player
@onready var image = $Image
var waitingInput = false
var receivedInput = false
var skipText = false

var dialogueTable1 = {
	0: { "text": [
		"Where am I?",
		"What is this strange place?"
	], "frame": [8] },
	1: { "text": [
		"What kind of hint is that?",
		"Is this guy dumb?"
	], "frame": [4] },
	2: { "text": [
		"These trees are truly beautiful.",
		"I wonder if they made this themselves or just stole it from the internet."
	], "frame": [2] },
	3: { "text": [
		"Nothing here..."
	], "frame": [0] },
	4: { "text": [
		"Who does this narrator think he is?"
	], "frame": [3] },
	# nu schimba 6, e pt scrisul de dupa deblocarea usii
	6: { "text": [
		"Wait, I'm starting to remember.",
		"I get it now. This isn't a tutorial.",
		"Not anymore."
	], "frame": [8, 8, 0] },
	10: { "text": [
		"Haven't I been here before?",
		"What's happening?"
	], "frame": [0] },
	11: { "text": [
		"I remember solving this puzzle already, but it seems more complicated now.",
		"I wonder what's going on."
	], "frame": [4, 0] },
	12: { "text": [
		"Pretty sure you've said that already..."
	], "frame": [0] },
	13: { "text": [
		"I'm quite sure one of them had armor last time.",
		"I should eliminate them this time, just to be sure."
	], "frame": [0, 7] },
	14: { "text": [
		"It feels like I used to know something... but I forgot what."
	], "frame": [6] },
	15: { "text": [
		"That's right, the Dash!",
		"How could I forget that?",
		"If only the portal worked, I could get the key..."
	], "frame": [1, 6, 0] },
	16: { "text": [
		"I feel like I need some kind of ability to reach that place."
	], "frame": [0] },
	17: { "text": [
		"You're acting weird..."
	], "frame": [4] },
	18: { "text": [
		"I'm having déjà vu."
	], "frame": [0] },
	19: { "text": [
		"That statue... I think it's new... It feels new."
	], "frame": [0] },
	20: { "text": [
		"There's nothing written on this one."
	], "frame": [0] },
	21: { "text": [
		"All this has happened before. I'm sure of it.",
		"This is where it all ends.",
		"Or where it all begins.",
		"I don't know how to feel about what's coming..."
	], "frame": [0, 0, 0, 6] },
	22: { "text": [
		"I'm sure I knew this already."
	], "frame": [0] },
	30: { "text": [
		"What is this place?"
	], "frame": [0] },
	31: { "text": [
		"I think we left the tutorial behind a long time ago, buddy.",
		"And I think you know that too."
	], "frame": [0] },
	32: { "text": [
		"It smells like death in here. The scent of time slipping away."
	], "frame": [0] },
	33: { "text": [
		"All these graves... Maybe others tried to escape too.",
		"Wait, how many people have been trapped here?"
	], "frame": [0, 6] },
	34: { "text": [
		"No... It can't be."
	], "frame": [8] },
	35: { "text": [
		"Everything seems broken now."
	], "frame": [0] },
	36: { "text": [
		"I don't think there's any puzzle left to solve, to be honest."
	], "frame": [0] },
	37: { "text": [
		"Wasn't I supposed to fight the dummies first?",
		"This place is falling apart."
	], "frame": [3, 0] },
	38: { "text": [
		"These tentacles... Good thing I remember how to dash.",
		"But why do I keep forgetting?",
		"It's like someone is messing with my head.",
		"My memories..."
	], "frame": [0, 6, 0, 0] },
	39: { "text": [
		"This ends here. It has to.",
		"Or will it just send me back to the graves?",
		"This was never a tutorial..."
	], "frame": [0] },
	100: { "text": [
		"Where am I?...",
		"Wait.",
		"You're...",
		"I AM.",
		"YOU HAVE BROKEN MY SPELL. YOU ESCAPED MY TRAP.",
		"This was never a tutorial. It was always you.",
		"You were the one I was meant to slay!",
		"I AM THE GOD OF MISCHIEF. YOU...",
		"YOU SAW THROUGH MY LIES.",
		"YOU BROKE THE ILLUSION.",
		"All that nonsense about getting started... How long has it been?",
		"DECADES. YOU'VE BEEN TRYING FOR DECADES.",
		"YOU NEVER GAVE UP.",
		"YOUR WILL... IT HAS DEFEATED ME.",
		"Then it's time to end this.",
		"DO IT. SLAY ME. YOU'VE EARNED IT."
	], "frame": [6, 0, 3, 9, 9, 0, 1, 9, 9, 9, 6, 9, 9, 9, 0, 9] }
}

var dialogueTable2 = {
	0: { "text": [
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
		"These rocks are truly beautiful.",
		"I wonder if they made this themselves or just stole it from the internet."
	], "frame": [1] },
	5: { "text": [
		"I hope I won't fall this time."
	], "frame": [4] },
	# nu schimba 6, e pt scrisul de dupa deblocarea usii
	6: { "text": [
		"Wait, I'm starting to remember.",
		"I get it now. This isn't a tutorial.",
		"Not anymore."
	], "frame": [8, 8, 0] },
	11: { "text": [
		"Why does the tutorial keep repeating? I've done this already."
	], "frame": [0] },
	12: { "text": [
		"Just get it over with."
	], "frame": [4] },
	13: { "text": [
		"If I go past this level, I can't get back to take the key unless the portal opens.",
		"Also, where is that narrator? He used to talk more."
	], "frame": [0] },
	14: { "text": [
		"This is where I unlock the Dash—I remember now.",
		"Let's hope the portal works and takes me back for the key."
	], "frame": [7] },
	15: { "text": [
		"I'm not sure what's going on."
	], "frame": [0] },
	17: { "text": [
		"But I didn’t say anything this time!",
		"Something definitely isn't right with you."
	], "frame": [3] },
	19: { "text": [
		"Maybe the secret code from the statue fits somewhere in the earlier levels!"
	], "frame": [1] },
	20: { "text": [
		"There's nothing written on this one."
	], "frame": [0] },
	21: { "text": [
		"Let's try again."
	], "frame": [0] },
	22: { "text": [
		"I miss the moments when you were quiet."
	], "frame": [4] },
	30: { "text": [
		"The graveyard... again."
	], "frame": [0] },
	31: { "text": [
		"I have to get back to the end."
	], "frame": [0] },
	32: { "text": [
		"Smells like death in here. The scent of time passing."
	], "frame": [0] },
	33: { "text": [
		"All these tombs... Maybe I can find an open one."
	], "frame": [0] },
	34: { "text": [
		"No... It can't be."
	], "frame": [8] },
	36: { "text": [
		"Still no puzzle..."
	], "frame": [0] },
	18: { "text": [
		"I'm having another déjà vu."
	], "frame": [0] },
	99: { "text": [
		"It's... me...",
		"But the mirror looks cracked."
	], "frame": [8, 8] }
}

var dialogueTable3 = {
	0: { "text": [
		"Where am I?",
		"What is this strange place?"
	], "frame": [8] },
	1: { "text": [
		"What kind of hint is that?",
		"Is this guy dumb?"
	], "frame": [4] },
	2: { "text": [
		"These trees are truly beautiful.",
		"I wonder if they made this or just stole it from the internet."
	], "frame": [2] },
	3: { "text": [
		"Nothing here..."
	], "frame": [0] },
	4: { "text": [
		"Who does this narrator think he is?"
	], "frame": [3] },
	# nu schimba 6, e pt scrisul de dupa deblocarea usii
	6: { "text": [
		"Wait, I'm starting to remember.",
		"I get it now. This isn't a tutorial.",
		"Not anymore."
	], "frame": [8, 8, 0] },
	17: { "text": [
		"Hmm..."
	], "frame": [0] },
	12: { "text": [
		"Yeah, yeah..."
	], "frame": [0] },
	11: { "text": [
		"Let's try the code from the statue."
	], "frame": [0] },
	13: { "text": [
		"After I unlock the Dash, I should come back to grab the key."
	], "frame": [0] },
	14: { "text": [
		"Finally! Now I can return after getting the Dash."
	], "frame": [4] },
	18: { "text": [
		"I'm having another déjà vu."
	], "frame": [0] },
	20: { "text": [
		"There's nothing written on this one."
	], "frame": [0] },
	21: { "text": [
		"Let's try again."
	], "frame": [0] },
	19: { "text": [
		"Maybe the secret code from the statue fits somewhere in the earlier levels!"
	], "frame": [1] }
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
	var dialogueTable = dialogueTable1
	if Global.playerVisitCount > 0:
		if Global.playerVisitCount == 1:
			dialogueTable = dialogueTable2
		elif Global.playerVisitCount >= 2:
			dialogueTable = dialogueTable3
		else:
			return
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
