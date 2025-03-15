extends Button


var button_toggled : bool = false


func _ready() -> void :
	pressed.connect(on_pressed)
	(SpeedScale as ASpeedScale).began_bending_time.connect(
		func() -> void :
			text = "Bending Time"
	)
	(SpeedScale as ASpeedScale).stopped_bending_time.connect(
		func() -> void : 
			text = "Chilling"
	)


func on_pressed() -> void : 
	(SpeedScale as ASpeedScale).toggle()
	(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)
