extends Node2D

@onready var label = $Label
@onready var player = %Player

var notesLines = {
	0: [ 
		"New ability unlocked: DASH"
	],
	1: [
		"You haven't unlocked the dash yet."
	],
	2: [
		"No dashing allowed here, buddy."
	],
	3: [
		"You can't dash in that direction."
	]
}

func ShowNoteById(lineID):
	visible = true
	label.text = notesLines[lineID][0]
	await get_tree().create_timer(5).timeout
	visible = false
