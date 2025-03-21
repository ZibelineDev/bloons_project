extends Label


func _ready() -> void :
	if SSS.activated : 
		text = "Victory !"
	else : 
		text = "Hardcore Victory !" 
