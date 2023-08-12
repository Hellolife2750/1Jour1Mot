extends Position2D

onready var root = get_tree().root.get_node("Master")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AddWordBtn_pressed():
	root.wordsDescriptions.push_back([str($WordName.text), str($WordDescription.text)])
	
	var newWordId:int = len(root.wordsDescriptions)-1
	
	if root.unlearnedWords.size() == 0:
		root.unlearnedWords = [newWordId]
	else:
		var randomIndex = 1 + randi() % (root.unlearnedWords.size() - 1)
		root.unlearnedWords.insert(randomIndex, newWordId)
	
	$WordName.text = "Name"
	$WordDescription.text = "Description..."
	
	root.refreshMainScreen()
	#print(root.wordsDescriptions)
