class_name SuperMonkeyTurret extends Turret 


static var this_scene : String = "uid://ul65opl34wt8"
static var this_resource : String = "uid://cmvn68axxmm4"

@onready var sprites: Node2D = %Sprites
@onready var hand: Sprite2D = %Hand


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func fire(target : Balloon) -> void :
	var direction : Vector2 = (target.global_position - global_position).normalized()
	add_child(Bullet.create(direction, resource.turret_range + 10.0 , 0, 1750.0))
	sprites.rotation = direction.angle()
	fire_animation()


func fire_animation() -> void : 
	var tween : Tween = create_tween()
	tween.tween_property(hand, "position:x", 24, 0.1)
	tween.tween_property(hand, "position:x", 0, 0.1)


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.SUPERMONKEY_RANGE]


func apply_first_upgrade() -> void : 
	resource.turret_range += 100.0
	update_range()


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.FROZEN_RANGE]


func apply_second_upgrade() -> void : 
	pass
