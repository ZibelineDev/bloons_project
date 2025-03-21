class_name WaveButton extends Button


func _ready() -> void :
	pressed.connect(on_pressed)


func _input(event : InputEvent) -> void :
	if event.is_action_pressed("space") : on_pressed()


func on_pressed() -> void : 
	if not SpeedScale.pause_toggled : 
		Waves.ref.initiate_wave()
