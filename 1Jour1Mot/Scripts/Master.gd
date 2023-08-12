extends Node2D

var wordsDescriptions = [["taciturne", "Qui parle habituellement peu, n'est pas d'humeur à faire la conversation"],
["salutaire", "Qui a une action favorable"],
["latent", "Qui reste caché"],
["indigent", "Qui manque de choses nécessaires, pauvre"],
["allégeance", "Obligation de fidélité"],
["abscon", "Difficile à comprendre"],
["exacerber", "Rendre plus intense (un mal)"],
["vicieux", "Qui aime faire le mal"],
["dépravé", "Corrompu moralement"],
["ébahi", "Très étonné"],
["allégresse", "Joie intense manifestée publiquement"],
["circonspect", "Qui est prudent dans ses actes"],
["apathique", "Qui manque d'énergie"],
["indolent", "Qui évite les efforts"],
["nonchalent", "Qui manque d'activité"],
["aduler", "Combler de louanges"],
["complaisance", "S'accomoder aux goûts d'autrui pour lui plaire"],
["pragmatique", "Qui concerne la pratique"],
["factuel", "Qui s'en tient aux faits"],
["piété", "Attachement fait de tendresse et de respect"],
["loquace", "Qui parle volontiers"],
["lunatique", "Qui a l'humeur changeante"],
["fantasque", "Dont on ne peut prévoir le comportement"],
["versatile", "Qui change facilement d'opinion"],
["zèle", "Ardeur à servir une personne ou une cause"],
["perspicace", "Doué d'un esprit subtil"],
["insipide", "Qui n'a aucune saveur"],
["éluder", "Éviter avec adresse (un problème)"],
["fallacieux", "Trompeur"],
["placide", "Calme"],
["ahuri", "Surpris à en être stupide"],
["hébété", "Surpris à en être stupide"],
["emphatique", "Qui en fait trop"],
["opulent ", "Très riche"],
["frugal", "Nourriture simple et peu abondante"],
["belliqueux", "Qui aime faire la guerre"],
["hardi", "Qui ose sans se laisser intimider"],
["clivant", "Sujet qui divise l'opinion"],
["manichéen", "Sans nuance, binaire"],
["intrinsèque", "Qui est propre à ce dont il s'agit"],
["grégaire", "Qui vit en troupeaux"],
["idoine", "Adéquat (plaisanterie)"],
["naguère", "Il y a peu de temps"],
["expier", "Réparer son erreur en en étant puni"],
["épier", "Observer secrètement"],
["casanier", "Qui aime rester chez soi"],
["abhorrer", "Avoir en horreur"],
["admonester", "Réprimer en avertissant de ne pas recommencer"],
["affectation", "Manque de naturel (comportement, style)"],
["alléguer", "Prétexter quelque chose pour justifier"],
["connivent", "Qui tend à se rapprocher"],
["connivence", "Accord sous-entendu"],
["tacite", "Non exprimé, sous-entendu"],
["éluder", "Éviter adroitement quelque chose"],
["escamoter", "Faire disparaître adroitement quelque chose"],
["dispendieux", "Qui exige une grande dépense"],
["fantasque", "Dont on ne peut prévoir le comportement, original"],
["frénésie", "Violence extrême"],
["exaltation", "Grande excitation de l'esprit"],
["harassant", "Très fatiguant"],
["éreinter", "Fatiguer"],
["vénal", "Qui se laisse acheter au mépris de la morale"],
["oisif", "Qui est dépourvu d'occupation"],
["désœuvré", "Qui est dépourvu d'occupation"],
["archaïque", "Qui est très ancien"],
["mystifier", "Abuser de la crédulité"],
["spécieux", "Qui est sans valeur (raisonnement)"],
["fallacieux", "Qui cherche à tromper, à nuire"],
["perfide", "Nuisible sans qu'il n'y paraisse"],
["nanti", "Riche"],
["sagace", "Qui fait preuve de finesse d'esprit"],
["affable", "Qui écoute volontier ceux qui s'adressent à lui"],
["dubitatif", "Qui exprime le doute"],
["insanité", "Caractère de ce qui est déraisonnable"],
["idiolecte", "Usage particulier d'une langue qu'a une personne"],
["circonspect", "Qui est attentif et prudent"],
["cupide", "Avide d'argent"],
["timoré", "Qui est trop méfiant, craint l'imprévu"],
["diligent", "Qui agit avec rapidité et efficacité"],
["impétueux", "Qui a de la rapidité et de la violence dans son comportement"],
["invétéré", "Endurci de l'expérience par la durée"],
["immuable", "Qui ne change pas"],
["véhément", "Qui a une grande force expressive"],
["pédant", "Qui manifeste prétentieusement son savoir"],
["condescendant", "Arrogant"],
["hautain", "Arrogant"],
["sustenter", "Soutenir ses forces par la nourriture"],
["abnégation", "Sacrifice volontaire de son intérêt"],
["résilience", "Capacité à surmonter les chocs traumatiques"],
["mondain", "Relatif à la société des gens fortunés"],
["frivole", "Futile"],
["fourvoyer", "Tromper"],
["nonobstant", "Cependant"],
["amalgame", "Mélange d'éléments divers"],
["superfétatoire", "Qui s'ajoute inutilement"],
["libidineux", "Qui recherche constamment et sans pudeur des satisfactions sexuelles"],
["timoré", "Qui est trop méfiant, craint l'imprévu"],]


var version:String = "1.0.0"

var revisedWords = [] #liste [id, dateDerniereRevision] avec les révisés le plus recemment en premiere position
var learnedWords = [] #liste [id, dateApprentissage] avec les appris le plus recemment en premiere position
var unlearnedWords = [] #liste des id dans n'importe quel ordre des mots restants à apprendre
var nbOfWordsToLearn

var todayWord:int = -1

var todayWords = []

var allTextureButtons

var wordListPath:String = "res://AppDatas/wordList.json"
var savePath: String = "user://1jour_1mot_data.dat"

onready var mainScreen = $MainScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	allTextureButtons = get_texture_buttons(self)
	
	loadData()
	
	"""if todayWord == -1:
		var today = $MainScreen.getCurrentDate()
		var alreadyLearnedToday:bool = false
		for id in learnedWords.keys():
			if today == learnedWords[id][0]:
				alreadyLearnedToday = true
				break
		if not alreadyLearnedToday:
			todayWord = unlearnedWords[randi()%(len(unlearnedWords))]"""
	
	updateWordsDescriptions()
	
	refreshMainScreen()
	
func updateWordsDescriptions():
	while nbOfWordsToLearn != len(wordsDescriptions):
		addNewWordToLearn(nbOfWordsToLearn)
		nbOfWordsToLearn += 1
		
func addNewWordToLearn(newWordId:int)->void:
	#var newWordId:int = len(root.wordsDescriptions)-1
	if unlearnedWords.size() == 0:
		unlearnedWords = [newWordId]
	else:
		var randomIndex = 1 + randi() % (unlearnedWords.size() - 1)
		unlearnedWords.insert(randomIndex, newWordId)

#rafraichit l'écran principal en actualisant la barre de progression et les mots du jour affichés
func refreshMainScreen()->void:
	#mainScreen.updateWords(wordsDescriptions[todayWord][0], 'undef', 'undef', 'undef')
	todayWords = getTodayWords()
	#mainScreen.todayWords = todayWords
	#print(wordsDescriptions[todayWords[0]])
	mainScreen.updateWords(isToDayWordLearned(), wordsDescriptions[todayWords[0]][0], wordsDescriptions[todayWords[1]][0], wordsDescriptions[todayWords[2]][0], wordsDescriptions[todayWords[3]][0])
	mainScreen.updateProgressBar(len(learnedWords), len(wordsDescriptions))
	
	saveData()
	
#func fillDefaultUnlearnedWords():
	#for i in range(len(wordsDescriptions)):
		#unlearnedWords.append(i)

#crée un tableau contenant des les nombres allant de 0 à limit-1 dans un ordre aléatoire
func randomWordsListToLearn(limit: int) -> Array:
	var numbers = []
	for i in range(limit):
		numbers.append(i)
	
	var randomOrder = []
	while numbers.size() > 0:
		var randomIndex = randi() % numbers.size()
		randomOrder.append(numbers[randomIndex])
		numbers.remove(randomIndex)
	
	return randomOrder

		
func loadData() -> void:
	var file = File.new()
	if file.file_exists(savePath):
		file.open(savePath, File.READ)
		var data = file.get_var()
		for vr in data.keys():
			set(vr, data[vr])
		file.close()
		print('loaded')
	else:
		nbOfWordsToLearn = len(wordsDescriptions)
		unlearnedWords =  randomWordsListToLearn(len(wordsDescriptions))
		#fillDefaultUnlearnedWords()
		saveData()

func saveData() -> void:
	var data = {
		'learnedWords' : learnedWords,
		'unlearnedWords' : unlearnedWords,
		'revisedWords' : revisedWords,
		'nbOfWordsToLearn': nbOfWordsToLearn,
	}
	
	var file = File.new()
	file.open(savePath, File.WRITE)
	file.store_var(data)
	file.close()
	print('saved')
	
func deleteSave():
	var saveFile = File.new()
	if saveFile.file_exists(savePath):
		var saveDir = Directory.new()
		saveDir.remove(savePath)
	get_tree().quit()
	
"""func learnWord(id:int):
	unlearnedWords.remove(id)
	learnedWords[str(id)] = [$MainScreen.getCurrentDate(), null]
	todayWord = -1"""

#retorune array de 4 id des mots du jour
func getTodayWords():
	var words = []
	var wordOfToday
	var secondWord
	var thirdWord
	if len(learnedWords) >= 1: 
		if learnedWords[0][1] == mainScreen.getCurrentDate():
			wordOfToday = learnedWords[0][0]
			if len(learnedWords) >= 2:
				secondWord = learnedWords[1][0]
				thirdWord = learnedWords[1][0]
			if len(learnedWords) >= 3:
				secondWord = learnedWords[1][0]
				thirdWord = learnedWords[2][0]
			#if len(learnedWords) >= 3: thirdWord = learnedWords[2][0]
			#words = [learnedWords[0][0], learnedWords[1][0], learnedWords[2][0], getOldestUnrevisedWord()]
		else:
			wordOfToday = unlearnedWords[0]
			if len(learnedWords) >= 2:
				secondWord = learnedWords[0][0]
				thirdWord = learnedWords[1][0]
			#if len(learnedWords) >= 2:secondWord = learnedWords[0][0]
			#if len(learnedWords) >= 3: thirdWord = learnedWords[1][0]
			#words = [unlearnedWords[0], learnedWords[1][0], learnedWords[2][0], getOldestUnrevisedWord()]
		if len(learnedWords) == 1: #décalage de 1 dans les learnwords selon si le mot du jour a été appris ou bien
			words = [wordOfToday, learnedWords[0][0], learnedWords[0][0], learnedWords[0][0]]
		elif len(learnedWords) == 2:
			words = [wordOfToday, secondWord, thirdWord, getOldestUnrevisedWord()]
		elif len(learnedWords) >= 3:
			words = [wordOfToday, secondWord, thirdWord, getOldestUnrevisedWord()]
	else:
		words = [unlearnedWords[0], unlearnedWords[0], unlearnedWords[0], unlearnedWords[0]]
	return words
	#for word in learnedWords:

#ajoute le mot du jour à ceux appris et le retire de ceux à apprendre
func learnTodayWord():
	var wordId = unlearnedWords.pop_front()
	learnedWords.push_front([wordId, mainScreen.getCurrentDate()])
	revisedWords.push_front([wordId, mainScreen.getCurrentDate()])
	
	refreshMainScreen()
	
func reviseWord(id:int):
	for word in revisedWords:
		if id == word[0]:
			revisedWords.erase(word)
			revisedWords.push_front([id, mainScreen.getCurrentDate()])
			break
			
	refreshMainScreen()

#renvoie si le mot du jour a été appris ou non
func isToDayWordLearned()->bool:
	return len(learnedWords) > 0 and learnedWords[0][1] == mainScreen.getCurrentDate()

func isWordAlreadyRevisedToday(wordId:int)->bool:
	for word in revisedWords:
		if word[0] == wordId:
			print(word[1])
			print(mainScreen.getCurrentDate())
			return word[1] == mainScreen.getCurrentDate()
	return false

#retoune l'id du mot le plus ancien non revisé
func getOldestUnrevisedWord()->int:
	return revisedWords.back()[0]
	
func _process(_delta):
	
	#version de debogage ordinateur
	if Input.is_action_just_pressed("click"):
		for m in allTextureButtons:
			if m.pressed:
				m.rect_scale = Vector2(.9, .9)
	elif Input.is_action_just_released("click"):
		for m in allTextureButtons:
			m.rect_scale = Vector2(1, 1);
	
	
#renvoie une liste de tous les textureboutons contenus dans le menu
func get_texture_buttons(node):
	var texture_buttons = []
	for child in node.get_children():
		if child is TextureButton:
			texture_buttons.append(child)
		else:
			var child_texture_buttons = get_texture_buttons(child)
			if child_texture_buttons:
				texture_buttons += child_texture_buttons
	for btn in texture_buttons:
		btn.rect_pivot_offset = btn.rect_size/2
	return texture_buttons


#effet de bouton pressé sur téléphone
func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch):
		if (not event.is_pressed()):
			for m in allTextureButtons:
				m.rect_scale = Vector2(1, 1);
		elif event.is_pressed():
			for m in allTextureButtons:
				if m.pressed:
					m.rect_scale = Vector2(.9, .9)


func _on_WordListBtn_pressed():
	$AnimsPlayer.play("MenuToWordList")
	
func _on_AddWordListBtn_pressed():
	$AnimsPlayer.play("MenuToAddWord")

func _on_HomeBtn_pressed():
	$AnimsPlayer.play("WordListToMenu")


func _on_HomeBtnAddWord_pressed():
	$AnimsPlayer.play("AddWordToMenu")
