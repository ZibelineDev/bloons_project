class_name TackTurret extends Turret


static var this_scene : String = "uid://cxkrlk42blgoo"
static var this_resource : String = "uid://bs5qk4acwxdp4"


static var directions : Array[Vector2] = [
	Vector2.UP,
	(Vector2.UP + Vector2.RIGHT).normalized(),
	Vector2.RIGHT,
	(Vector2.DOWN + Vector2.RIGHT).normalized(),
	Vector2.DOWN,
	(Vector2.DOWN + Vector2.LEFT).normalized(),
	Vector2.LEFT,
	(Vector2.UP + Vector2.LEFT).normalized(),
]


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(_target : Balloon) -> void :
	for direction : Vector2 in directions :
		add_child(Bullet.create(direction, resource.turret_range + 25.0))
	fire_animation()


func fire_animation() -> void : 
	var tween : Tween = create_tween()
	tween.tween_property(%Canons, "scale", Vector2(0.95, 0.95), 0.1)
	tween.tween_property(%Canons, "scale", Vector2(1.0, 1.0), 0.2)
	
	#var body_tween : Tween = create_tween()
	#body_tween.tween_property(%Body, "rotation", deg_to_rad(360.0), 0.3).from(0.0)
	
	var body_tween : Tween = create_tween()
	var body_rotation : float = (%Body as Sprite2D).rotation + deg_to_rad(45.0)
	body_tween.tween_property(%Body, "rotation", body_rotation, 0.3)
	var canon_rotation : float = (%Canons as Sprite2D).rotation + deg_to_rad(-45.0)
	tween.set_parallel(true)
	tween.tween_property(%Canons, "rotation", canon_rotation, 0.3)


func select() -> void : 
	super()


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.TACK_SPEED]


func apply_first_upgrade() -> void : 
	super()
	resource.cooldown -= 0.5


func get_second_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.TACK_RANGE]


func apply_second_upgrade() -> void : 
	super()
	resource.turret_range += 25.0
	update_range()
