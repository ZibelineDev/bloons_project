extends MarginContainer


func _ready() -> void :
	if SSS.activated : visible = true
	else : visible = false
