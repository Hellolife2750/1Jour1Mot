extends Position2D

onready var root = get_tree().root.get_node("Master")
onready var wdDesPopup = get_tree().root.get_node("Master/WordDescriptionPopup")

#var todayWords = []


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$DateLabel.text = getCurrentDate()


func getCurrentDate():
	var date = OS.get_date()
	var day = date.day
	var month = date.month
	var year = date.year % 100

	var dateString = str(day).pad_zeros(2) + "/" + str(month).pad_zeros(2) + "/" + str(year).pad_zeros(2)
	return dateString
	
func updateWords(todayWordLearned:bool, word1, word2, word3, word4)->void:
	$Words/Word1.text = word1
	$Words/Word2.text = word2
	$Words/Word3.text = word3
	$Words/Word4.text = word4
	
	$Words/Word1.set("custom_colors/font_color", Color(0,0,0))
	if todayWordLearned:
		$Words/Word1.set("custom_colors/font_color", Color(0.27, .77, .09))
	
func updateProgressBar(nbWordsLearned:int, nbTotalWords:int):
	$ProgressionBar.value = float(nbWordsLearned) * 100 / nbTotalWords
	$ProgressionLabel.text = str(nbWordsLearned) + "/" + str(nbTotalWords)
	
func getWordsDescriptionsAsString()->void:
	var result = "["
	for i in range(root.wordsDescriptions.size()):
		result += "[" + '"' + root.wordsDescriptions[i][0] + '"' + ", " + '"' + root.wordsDescriptions[i][1] + '"' + "]"
		if i < root.wordsDescriptions.size() - 1:
			result += ", "
	result += "]"
	OS.set_clipboard(result)


func _on_ExportBtn_pressed():
	getWordsDescriptionsAsString()
	
func _on_Word1Hitbox_pressed():
	var theWord = root.wordsDescriptions[root.todayWords[0]]
	wdDesPopup.showPopup(theWord[0], theWord[1], root.todayWords[0], (not root.isToDayWordLearned()) and len(root.unlearnedWords) > 1)

func _on_Word2Hitbox_pressed():
	var theWord = root.wordsDescriptions[root.todayWords[1]]
	wdDesPopup.showPopup(theWord[0], theWord[1], root.todayWords[1], not root.isWordAlreadyRevisedToday(root.todayWords[1]))


func _on_Word3Hitbox_pressed():
	var theWord = root.wordsDescriptions[root.todayWords[2]]
	wdDesPopup.showPopup(theWord[0], theWord[1], root.todayWords[2], not root.isWordAlreadyRevisedToday(root.todayWords[2]))


func _on_Word4Hitbox_pressed():
	var theWord = root.wordsDescriptions[root.todayWords[3]]
	wdDesPopup.showPopup(theWord[0], theWord[1], root.todayWords[3], not root.isWordAlreadyRevisedToday(root.todayWords[3]))


func _on_RandomWordBtn_pressed():
	var index = randi()%len(root.wordsDescriptions)
	var theWord = root.wordsDescriptions[index]
	wdDesPopup.showPopup(theWord[0], theWord[1], index, false)
