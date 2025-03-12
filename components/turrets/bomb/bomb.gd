class_name BombTurret extends Turret


static var this_scene : String = "uid://cu327014ytild"
static var this_resource : String = "uid://dh3y4o2qayf4v"

var extra_radius : float = 0.0
var reload : Tween

@onready var missile: Sprite2D = %Missile


func _ready() -> void :
	super()
	reload = get_tree().create_tween()
	reload.tween_property(missile, "scale", Vector2(1.0, 1.0), 1.0)
	reload.set_parallel()
	reload.tween_property(missile, "modulate", Color.WHITE, 1.0).from(Color.BLACK)
	reload.finished.connect(func() -> void : reload.stop())
	reload.stop()


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(target : Balloon) -> void :
	var canon_ball_range : Vector2 = (target.global_position - global_position)
	var direction : Vector2 = canon_ball_range.normalized()
	
	add_child(CanonBall.create(direction, canon_ball_range.length(), 1750.0))
	fire_animation(direction)


func fire_animation(direction : Vector2) -> void : 
	missile.rotation = direction.angle() + deg_to_rad(90)
	missile.scale = Vector2.ZERO
	reload.play()


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.BOMB_RADIUS]


func apply_first_upgrade() -> void : 
	super()
	extra_radius = 10.0


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.BOMB_RANGE]


func apply_second_upgrade() -> void : 
	super()
	resource.turret_range += 25.0
	update_range()
