class_name Game extends Node


static var ref : Game


signal game_over(just_won : bool)


@onready var world: World = %World


func _init() -> void :
	ref = self


signal lives_updated(new_value : int)


var lives : int = 40


func _ready() -> void :
	lives = 40
	lives_updated.emit(40)
	Augments.initialise()
	(Currency as ACurrency).initialise()
	Waves.ref.initialise()
	(SpeedScale as ASpeedScale).initialise()


func lose_life(quantity : int = 1) -> void : 
	lives -= quantity
	lives_updated.emit(lives)
	
	if lives <= 0 : 
		game_over_func()


func game_over_func(just_won : bool = false) -> void : 
	game_over.emit(just_won)
	if not just_won : 
		Engine.time_scale = 0.0
	else : 
		if SpeedScale.is_bending_time() :
			SpeedScale.toggle()


func reset() -> void : 
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
