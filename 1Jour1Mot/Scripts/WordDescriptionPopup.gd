extends Panel


onready var root = get_tree().root.get_node("Master")

onready var bk = $Background

var currentDisplayedWordId:int


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


func _process(_delta):
	if Input.is_action_just_pressed("click"):
		if visible and not isMenuClicked():
			hidePopup()
			
#effet de disparition si clické en dehors du popup sur téléphone
func _input(event: InputEvent) -> void:
	if (event is InputEventScreenTouch):
		if (event.is_pressed()):
			if visible and not isMenuClicked():
				hidePopup()
			
func isMenuClicked() ->bool:
	var mouse_pos = get_viewport().get_mouse_position()
	return (mouse_pos.x >= bk.rect_position.x) and (mouse_pos.x <= ( bk.rect_position.x+bk.rect_size.x)) and (mouse_pos.y >=  bk.rect_position.y) and (mouse_pos.y <= ( bk.rect_position.y + bk.rect_size.y))

func showPopup(word:String, description:String, wordId:int = 0, learnable = true)->void:
	$CoolDown.start()
	visible = true
	$Title.text = word
	$Description.bbcode_text = "[center]" + description + "[/center]"
	currentDisplayedWordId = wordId
	
	$LearnBtn.disabled = not learnable
	
func hidePopup():
	if $CoolDown.time_left < 0.01:
		visible = false	

func _on_LearnBtn_pressed():
	print(currentDisplayedWordId)
	if currentDisplayedWordId == root.unlearnedWords[0]:
		root.learnTodayWord()
		print("learned")
	else:
		root.reviseWord(currentDisplayedWordId)
		print("revised")
	hidePopup()
