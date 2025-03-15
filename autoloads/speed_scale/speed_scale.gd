class_name ASpeedScale extends Node


signal began_bending_time
signal stopped_bending_time


# For Bending Time
var toggled : bool
var pause_toggled : bool 


func initialise() -> void : 
	toggled = false
	pause_toggled = false
	Engine.time_scale = 1.0
	Engine.physics_ticks_per_second = 60


func is_bending_time() -> bool :
	return toggled


func toggle() -> void : 
	toggled = not toggled
	if not toggled : 
		Engine.time_scale = 1.0
		Engine.physics_ticks_per_second = 60
		stopped_bending_time.emit()
	else : 
		Engine.time_scale = 4.0
		Engine.physics_ticks_per_second = 240
		began_bending_time.emit()


func toggle_pause(new_pause_toggled : bool) -> void : 
	pause_toggled = new_pause_toggled
	if pause_toggled : 
		Engine.time_scale = 0.0
	else : 
		if GameOver.is_over : return
		if toggled : Engine.time_scale = 4.0
		else : Engine.time_scale = 1.0
	
