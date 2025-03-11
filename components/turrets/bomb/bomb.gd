class_name BombTurret extends Turret


static var this_scene : String = "uid://cu327014ytild"
static var this_resource : String = "uid://dh3y4o2qayf4v"

var extra_radius : float = 0.0


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(target : Balloon) -> void :
	var canon_ball_range : Vector2 = (target.global_position - global_position)
	var direction : Vector2 = canon_ball_range.normalized()
	
	add_child(CanonBall.create(direction, canon_ball_range.length(), 1750.0))
	fire_animation()


func fire_animation() -> void : 
	pass


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.BOMB_RADIUS]


func apply_first_upgrade() -> void : 
	extra_radius = 10.0


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.BOMB_RANGE]


func apply_second_upgrade() -> void : 
	resource.turret_range += 25.0
	update_range()
