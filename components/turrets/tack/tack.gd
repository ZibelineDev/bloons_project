class_name TackTurret extends Turret


static var this_scene : String = "uid://cxkrlk42blgoo"
static var this_resource : String = "uid://bs5qk4acwxdp4"


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret
