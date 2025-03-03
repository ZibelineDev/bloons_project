class_name WaveLabel extends Label


func _ready() -> void :
	Waves.ref.wave_completed.connect(on_wave_completed)


func on_wave_completed(new_value : int) -> void : 
	text = "Waves Completed : %s" %new_value
