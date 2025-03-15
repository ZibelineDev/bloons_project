class_name CanonBall extends Area2D


const SCENE : String = "uid://bgpv6b5cx4qx5"


var target : Balloon
var direction : Vector2
var bullet_range : float = 75.0
var speed : float = 1000.0
var radius : float = 60.0

var lifespan : float = 1.0


func _ready() -> void :
	update_radius()
	fire_alpha_tween()


static func create(_direction : Vector2, _range : float, _speed : float = 1000.0, extra_radius : float = 0.0) -> CanonBall : 
	var canon_ball : CanonBall = (preload(SCENE) as PackedScene).instantiate()
	canon_ball.direction = _direction
	canon_ball.bullet_range = _range
	canon_ball.speed = _speed 
	canon_ball.radius += extra_radius
	canon_ball.rotation = _direction.angle() + deg_to_rad(90)
	return canon_ball


func _physics_process(delta : float) -> void :
	position += direction * speed * delta
	
	bullet_range -= speed * delta 
	lifespan -= delta
	
	if lifespan <= 0.0 or bullet_range <= 0.0 : 
		scan_for_balloon()
		MissileParticlesPool.ref.trigger(global_position)


func scan_for_balloon() -> void : 
	var balloon_areas : Array[Area2D] = get_overlapping_areas()
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		balloon_area.balloon.pop(false)
	
	queue_free()


func update_radius() -> void :
	((%CollisionShape2D as CollisionShape2D).shape as CircleShape2D).radius = radius


func fire_alpha_tween() -> void :
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.1).from(0.0).set_trans(Tween.TRANS_CIRC)
