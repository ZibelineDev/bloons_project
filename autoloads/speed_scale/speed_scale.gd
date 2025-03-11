class_name ASpeedScale extends Node


signal began_bending_time
signal stopped_bending_time


var toggled : bool = false


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
