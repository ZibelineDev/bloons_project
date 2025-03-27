class_name SSSCheckBox extends TextureButton


var texture_unchecked : Texture2D = load("uid://cjsjh8fkugned")
var texture_checked : Texture2D = load("uid://dvt37mm844rti")

var checked : bool = false


func _ready() -> void :
	if SSS.activated : 
		check()
	else : 
		uncheck()
	
	pressed.connect(
		func() -> void :
			if checked : uncheck()
			else : check()
			(Sounds as ASounds).play_ui_sound(ASounds.UISounds.SWITCH)
	)


func check() -> void : 
	texture_normal = texture_checked
	checked = true


func uncheck() -> void : 
	texture_normal = texture_unchecked
	checked = false
