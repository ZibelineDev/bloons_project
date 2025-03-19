class_name Balloon extends PathFollow2D


static var scene : PackedScene = load("uid://7tgh7f8vdhwo")


static var greed_proc_rate : float = 0.1
static var greed_magnitude : int = 0

var speed : float = 75.0
var level : int = 0

var frozen : bool = false
var frozen_progress : float = 0.0
var freeze_in : Tween
var freeze_out : Tween
var freeze_count : int = 0
var freeze_protection : float = 0.0


@onready var base: Sprite2D = %Base
@onready var frozen_effect: Sprite2D = %FrozenEffect


func _ready() -> void :
	update()
	initialise_tweens()
	frozen_effect.modulate.a = 0.0
	
	if SSS.activated : 
		Augments.augment_purchased.connect(
			func(augment : RAugment) -> void : 
				if augment.key == RAugment.Types.GREED :
					greed_magnitude += 1
		)


static func create(_level : int = 0) -> Balloon : 
	var balloon : Balloon = scene.instantiate()
	balloon.h_offset = randi_range(-15, 15)
	balloon.v_offset = randi_range(-15, 15)
	balloon.level = _level
	return balloon


func _physics_process(delta : float) -> void :
	if frozen :
		frozen_progress -= delta
		if frozen_progress <= 0 :
			frozen = false
			freeze_out.play()
			if freeze_count >= 3 : 
				freeze_protection = 2.5
		return
	
	if freeze_protection > 0.0 : 
		freeze_protection -= delta
	
	progress += delta * speed
	
	if progress_ratio >= 1.0 : 
		bonk()


func initialise_tweens() -> void : 
	freeze_in = get_tree().create_tween()
	freeze_in.tween_property(frozen_effect, "modulate:a", 1.0, 0.1)
	freeze_in.finished.connect(func() -> void : freeze_in.stop())
	freeze_in.stop()
	
	freeze_out = get_tree().create_tween()
	freeze_out.tween_property(frozen_effect, "modulate:a", 0.0, 0.1)
	freeze_out.finished.connect(func() -> void : freeze_out.stop())
	freeze_out.stop()


func update() -> void : 
	update_scale()
	update_colour()
	update_speed()


func freeze(duration : float) -> void :
	if not level == 5 and freeze_protection <= 0.0 : 
		frozen = true
		frozen_progress = duration
		freeze_in.play()
		freeze_count += 1 


func update_scale() -> void :
	match level : 
		4, 5 : scale = Vector2(0.80, 0.80)
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


func pop(dart_damage : bool = true) -> void : 
	if frozen and dart_damage : 
		return
	if level == 4 and not dart_damage : 
		return
	
	(Sounds as ASounds).play_pop()
	(Currency as ACurrency).create_currency(1)
	
	if greed_magnitude >= 1 :
		var roll : float = randf()
		if roll <= greed_proc_rate :
			print_rich("[color=ff18a6]Greeded 1 Money[/color]")
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
		BalloonPopsPool.ref.trigger_balloon_pop(global_position)
		queue_free()


func create_sibling() -> void : 
	var sibling : Balloon = create(3)
	sibling.progress = progress
	add_sibling(sibling)


func bonk() -> void : 
	Game.ref.lose_life(1)
	(Sounds as ASounds).play_bonk()
	queue_free()
