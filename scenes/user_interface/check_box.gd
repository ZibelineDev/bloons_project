extends TextureButton


var texture_unchecked : Texture2D = load("uid://cx1fcg3q0khwh")
var texture_checked : Texture2D = load("uid://bb7xwy64538kg")

var checked : bool = false


func _ready() -> void :
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
