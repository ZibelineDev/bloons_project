class_name Bullet extends Area2D


const SCENE : String = "uid://dqnn853pecay3"


var target : Balloon
var direction : Vector2
var bullet_range : float = 75.0
var pierce : int = 0
var speed : float = 1000.0

var lifespan : float = 1.0


func _ready() -> void :
	rotate(direction.angle())
	fire_alpha_tween()


static func create(_direction : Vector2, _range : float, _pierce : int = 0, _speed : float = 1000.0) -> Bullet : 
	var bullet : Bullet = (preload(SCENE) as PackedScene).instantiate()
	bullet.direction = _direction
	bullet.bullet_range = _range
	bullet.pierce = _pierce
	bullet.speed = _speed 
	return bullet


func _physics_process(delta : float) -> void :
	position += direction * speed * delta
	
	bullet_range -= speed * delta 
	lifespan -= delta
	
	if lifespan <= 0.0 or bullet_range <= 0.0 : queue_free()
	
	scan_for_balloon()


func scan_for_balloon() -> void : 
	var balloon_areas : Array[Area2D] = get_overlapping_areas()
	var _target : BalloonArea2D = null
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		if _target == null or _target.get_progress_ratio() < balloon_area.get_progress_ratio() : 
			_target = balloon_area
	
	if _target : 
		_target.hit()
		pierce -= 1 
		
		if pierce < 0 :
			queue_free()


func fire_alpha_tween() -> void :
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2).from(0.0).set_trans(Tween.TRANS_CIRC)
