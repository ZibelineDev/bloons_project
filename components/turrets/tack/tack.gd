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
		add_child(Bullet.create(direction, resource.turret_range))


func select() -> void : 
	super()


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.TACK_SPEED]


func apply_first_upgrade() -> void : 
	resource.cooldown -= 0.5


func get_second_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.TACK_RANGE]


func apply_second_upgrade() -> void : 
	resource.turret_range += 25.0
	update_range()
