class_name Balloon extends PathFollow2D


static var scene : PackedScene = load("uid://7tgh7f8vdhwo")


@export var speed : float = 300.0


static func create() -> Balloon : 
	var balloon : Balloon = scene.instantiate()
	return balloon


func _physics_process(delta : float) -> void :
	progress += delta * speed
	
	if progress_ratio >= 1.0 : 
		bonk()


func pop() -> void : 
	(Sounds as ASounds).play_pew_pew()
	queue_free()


func bonk() -> void : 
	Game.ref.lose_life(1)
	(Sounds as ASounds).play_bonk()
	queue_free()
