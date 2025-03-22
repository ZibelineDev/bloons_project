extends Label


func _ready() -> void :
	if SSS.activated : 
		text = "Victory ! (Augmented)"
	else : 
		text = "Victory !" 
