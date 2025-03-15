extends Button


func _ready() -> void :
	pressed.connect(
		func() -> void : 
			(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)
			Game.ref.reset()
	)
