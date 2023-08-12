extends Position2D

onready var root = get_tree().root.get_node("Master")
onready var wdDesPopup = get_tree().root.get_node("Master/WordDescriptionPopup")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$VersionLabel.text = 'v' + root.version
	pass # Replace with function body.

func refresh():
	$RevisedWordList.clear()
	
	print(root.revisedWords)
	#root.revisedWords = [[0, "08/05/23"], [1, "08/05/23"]]
	#for word in root.revisedWords:
		#$RevisedWordList.add_item(root.wordsDescriptions[word[0]][0])
	for i in range(root.revisedWords.size() - 1, -1, -1):
		var wordIndex = root.revisedWords[i][0]
		$RevisedWordList.add_item(root.wordsDescriptions[wordIndex][0])


func _on_RevisedWordList_item_activated(_index):
	pass
	#var theWord = root.wordsDescriptions[root.revisedWords[index][0]]
	#wdDesPopup.showPopup(theWord[0], theWord[1], root.revisedWords[index][0])


func _on_RevisedWordList_item_selected(index):
	index = len(root.revisedWords)-1 - index
	var theWord = root.wordsDescriptions[root.revisedWords[index][0]]
	wdDesPopup.showPopup(theWord[0], theWord[1], root.revisedWords[index][0], not root.isWordAlreadyRevisedToday(root.revisedWords[index][0]))
	$RevisedWordList.unselect_all()


func _on_DeleteButton_pressed():
	if $DeleteDelay.time_left < .01:
		$DeleteDelay.start()
	elif $DeleteDelay.time_left > .1:
		root.deleteSave()
		
	
