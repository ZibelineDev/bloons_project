class_name DartTurret extends Turret


static var this_scene : String = "uid://c7wyccupdxmxc"
static var this_resource : String = "uid://dtsegxyhlj16x"


var pierce : int = 0


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(target : Balloon) -> void :
	var direction : Vector2 = (target.global_position - global_position).normalized()
	add_child(Bullet.create(direction, resource.turret_range + 10.0 , pierce, 1750.0))


func select() -> void : 
	super()


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.DART_PIERCE]


func apply_first_upgrade() -> void : 
	pierce = 1


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.DART_RANGE]


func apply_second_upgrade() -> void : 
	resource.turret_range += 50.0
	update_range()
