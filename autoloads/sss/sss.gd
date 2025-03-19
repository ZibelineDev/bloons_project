class_name ASSS extends Node


var activated : bool = false


func activate() -> void : 
	activated = true
	Game.ref.reset()


func deactivate() -> void :
	activated = false 
	Game.ref.reset()


func toggle() -> void: 
	if activated : deactivate()
	else : activate()
