class_name Balloon extends PathFollow2D


static var scene : PackedScene = load("uid://7tgh7f8vdhwo")


var speed : float = 75.0
var level : int = 0


@onready var base: Sprite2D = %Base


func _ready() -> void :
	update()


static func create(_level : int = 0) -> Balloon : 
	var balloon : Balloon = scene.instantiate()
	balloon.h_offset = randi_range(-15, 15)
	balloon.v_offset = randi_range(-15, 15)
	balloon.level = _level
	return balloon


func _physics_process(delta : float) -> void :
	progress += delta * speed
	
	if progress_ratio >= 1.0 : 
		bonk()


func update() -> void : 
	update_scale()
	update_colour()
	update_speed()


func update_scale() -> void :
	match level : 
		4, 5 : scale = Vector2(0.66, 0.66)
		_, 1, 2, 3 : scale = Vector2(1.0, 1.0)


func update_colour() -> void : 
	match level : 
		0 : base.modulate = Color.RED
		1 : base.modulate = Color.CORNFLOWER_BLUE
		2 : base.modulate = Color.LIME_GREEN
		3 : base.modulate = Color.YELLOW
		4 : base.modulate = Color.BLACK
		5 : base.modulate = Color.WHITE


func update_speed() -> void  : 
	match level : 
		0 : speed = 125.0
		1 : speed = 150.0
		2 : speed = 200.0
		3 : speed = 300.0
		4 : speed = 250.0
		5 : speed = 325.0


func pop() -> void : 
	(Sounds as ASounds).play_pop()
	(Currency as ACurrency).create_currency(1)
	
	if level == 4 : 
		level = 3
		create_sibling()
		update()
		return
	if level == 5 :
		level = 3
		create_sibling()
		update()
		return
	if level >= 1 : 
		level -= 1
		update()
		return
	if level <= 0 :
		queue_free()


func create_sibling() -> void : 
	var sibling : Balloon = create(3)
	sibling.progress = progress
	add_sibling(sibling)


func bonk() -> void : 
	Game.ref.lose_life(1)
	(Sounds as ASounds).play_bonk()
	queue_free()
