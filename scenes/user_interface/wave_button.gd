class_name WaveButton extends Button


func _ready() -> void :
	pressed.connect(on_pressed)


func on_wave_intited() -> void : 
	disabled = true


func on_wave_completed() -> void : 
	disabled = false


func on_pressed() -> void : 
	Waves.ref.initiate_wave()
