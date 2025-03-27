class_name Bullet extends Node2D


const SCENE : String = "uid://dqnn853pecay3"

@export_group("Hitbox")
@export var hitbox : Area2D
@export var collision_shape_2d : CollisionShape2D
@export var sprite2d : Sprite2D

@export_group("Chain")
@export var chain_area : Area2D


var target : Balloon
var direction : Vector2
var bullet_range : float = 75.0
var pierce : int = 0
var chain : int = 0
var speed : float = 1000.0
var snipe : Balloon = null
var will_snipe : bool = false

var lifespan : float = 1.0

static var guaranteed_shot_magnitude : int = 0


func _ready() -> void :
	apply_augments()
	rotate(direction.angle())
	fire_alpha_tween()


static func create(_direction : Vector2, _range : float, _pierce : int = 0, _speed : float = 1000.0, _snipe : Balloon = null) -> Bullet : 
	var bullet : Bullet = (preload(SCENE) as PackedScene).instantiate()
	bullet.direction = _direction
	bullet.bullet_range = _range
	bullet.pierce = _pierce
	bullet.speed = _speed 
	bullet.snipe = _snipe
	
	if guaranteed_shot_magnitude > 0 : 
		var roll : int = randi_range(0, 99)
		if roll < 50 : 
			bullet.will_snipe = true
	
	return bullet


func _exit_tree() -> void :
	if snipe and will_snipe : 
		snipe.pop()


func _physics_process(delta : float) -> void :
	position += direction * speed * delta
	
	bullet_range -= speed * delta 
	lifespan -= delta
	
	if lifespan <= 0.0 or bullet_range <= 0.0 : queue_free()
	
	scan_for_balloon()


func scan_for_balloon() -> void : 
	var balloon_areas : Array[Area2D] = hitbox.get_overlapping_areas()
	var _target : BalloonArea2D = null
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		if _target == null or _target.get_progress_ratio() < balloon_area.get_progress_ratio() : 
			_target = balloon_area
	
	if _target : 
		_target.hit()
		if _target.balloon == snipe : 
			snipe = null
		
		var chained : bool = try_to_chain()
		if chained : 
			#If we do find a target return
			if scan_for_chaining(_target.balloon) : return
			#Else we queue free
			else : 
				queue_free()
				return
		
		var pierced : bool = try_to_pierce()
		if pierced : 
			return
		
		queue_free()


func scan_for_chaining(previous_target : Balloon) -> bool : 
	var balloon_areas : Array[Area2D] = chain_area.get_overlapping_areas()
	var balloons : Array[Balloon] = []
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		balloons.append(balloon_area.balloon)
	balloons.erase(previous_target)
	
	if balloons.size() == 0 : return false
	
	var new_target : Balloon = balloons.pick_random()
	
	if new_target == null : return false
	
	direction = (new_target.global_position - global_position).normalized()
	target = new_target
	bullet_range += 75.0
	lifespan += 0.33
	
	rotation = 0
	rotate(direction.angle())
	
	return true


func try_to_chain() -> bool : 
	if chain <= 0 : return false
	
	chain -= 1 
	
	return true


func try_to_pierce() -> bool : 
	if pierce <= 0 : return false
	
	pierce -= 1
	
	return true


func fire_alpha_tween() -> void :
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.15).from(0.0).set_trans(Tween.TRANS_CIRC)


func apply_augments() -> void : 
	var growth_augment : RAugment = load(RAugment.dictionary[RAugment.Types.BIGGER_DARTS])
	var growth_magnitude : int = Augments.get_augment(growth_augment)
	
	if growth_magnitude : 
		(collision_shape_2d.shape as CapsuleShape2D).radius = 2 + 2 * growth_magnitude
		(collision_shape_2d.shape as CapsuleShape2D).height = 38 + 3 * growth_magnitude
		sprite2d.scale = Vector2(1.0 + 0.05 * growth_magnitude, 1.0 + 0.05 * growth_magnitude)
	
	
	
	var pierce_augment : RAugment = load(RAugment.dictionary[RAugment.Types.PIERCING_DARTS])
	var pierce_magnitude : int = Augments.get_augment(pierce_augment)
	
	if pierce_magnitude : 
		var chances : int = 0 + pierce_magnitude * 25
		var roll : int = randi_range(0, 99)
		
		if roll < chances : 
			pierce += 1 
	
	
	
	var minor_chain_augment : RAugment = load(RAugment.dictionary[RAugment.Types.MINOR_CHAIN])
	var minor_chain_magnitude : int = Augments.get_augment(minor_chain_augment)
	
	if minor_chain_magnitude : 
		var chain_chances : int = 0 + minor_chain_magnitude * 25
		var chain_roll : int = randi_range(0, 99)
		
		if chain_roll < chain_chances : 
			chain += 1
