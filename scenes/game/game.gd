class_name Game extends Node


static var ref : Game


func _init() -> void :
	ref = self


signal lives_updated(new_value : int)


var lives : int = 40


func _ready() -> void :
	#Engine.time_scale = 0.25
	lives = 40
	lives_updated.emit(40)
	(Currency as ACurrency).initialise()
	Waves.ref.initialise()


func lose_life(quantity : int = 1) -> void : 
	lives -= quantity
	lives_updated.emit(lives)
