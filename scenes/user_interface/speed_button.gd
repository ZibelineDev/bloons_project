extends Button


var button_toggled : bool = false


func _ready() -> void :
	pressed.connect(on_pressed)


func on_pressed() -> void : 
	button_toggled = not button_toggled
	if not button_toggled : 
		Engine.time_scale = 1.0
		Engine.physics_ticks_per_second = 60
		text = "Chilling"
	else : 
		Engine.time_scale = 4.0
		Engine.physics_ticks_per_second = 240
		text = "Bending Time"
