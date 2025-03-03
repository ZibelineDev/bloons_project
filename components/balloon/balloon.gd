class_name Balloon extends PathFollow2D


static var scene : PackedScene = load("uid://7tgh7f8vdhwo")


var speed : float = 300.0
var level : int = 0


func _ready() -> void :
	h_offset = randi_range(-10, 10)
	v_offset = randi_range(-10, 10)
	update()


static func create(_level : int = 0) -> Balloon : 
	var balloon : Balloon = scene.instantiate()
	balloon.level = _level
	return balloon


func _physics_process(delta : float) -> void :
	progress += delta * speed
	
	if progress_ratio >= 1.0 : 
		bonk()


func update() -> void : 
	update_colour()
	update_speed()


func update_colour() -> void : 
	match level : 
		0 : modulate = Color.RED
		1 : modulate = Color.CORNFLOWER_BLUE


func update_speed() -> void  : 
	match level : 
		0 : speed = 300.0
		1 : speed = 325.0


func pop() -> void : 
	(Sounds as ASounds).play_pew_pew()
	(Currency as ACurrency).create_currency(1)
	
	if level >= 1 : 
		level -= 1
		update()
	else :
		queue_free()


func bonk() -> void : 
	Game.ref.lose_life(1)
	(Sounds as ASounds).play_bonk()
	queue_free()
