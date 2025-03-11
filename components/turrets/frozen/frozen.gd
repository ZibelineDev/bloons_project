class_name FrozenTurret extends Turret


static var this_scene : String = "uid://bnwrwblkx6wm4"
static var this_resource : String = "uid://bah20vq8ns2mr"

var duration : float = 1.2


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(_target : Balloon) -> void :
	var balloons : Array[Area2D] = (%RangeArea as Area2D).get_overlapping_areas()
	for balloon_area : BalloonArea2D in balloons : 
		balloon_area.balloon.freeze(duration)


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.FROZEN_TIME]


func apply_first_upgrade() -> void : 
	duration += 0.55


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.FROZEN_RANGE]


func apply_second_upgrade() -> void : 
	resource.turret_range += 25.0
	update_range()
