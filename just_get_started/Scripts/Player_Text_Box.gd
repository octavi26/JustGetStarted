extends Node2D

@export var lineID = 0

var dialogueTable = {
	0: { "text": "Hello, traveler.", "frame": 1 },
	1: { "text": "What brings you to this land?", "frame": 2 },
	2: { "text": "Ah, I see. Be careful out there.", "frame": 3 },
}

# Function to display text one character at a time
func type_text(text: String, speed: float = 0.025) -> void:
	$Label.text = ""
	for i in text.length():
		$Label.text += text[i]
		await get_tree().create_timer(speed).timeout
		
func _ready() -> void:
	$Image.frame = dialogueTable.get(lineID)["frame"]
	await type_text(dialogueTable.get(lineID)["text"])
	
func _input(event): if event is InputEventKey and event.pressed: queue_free()
