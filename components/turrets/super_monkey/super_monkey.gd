class_name SuperMonkeyTurret extends Turret 


static var this_scene : String = "uid://ul65opl34wt8"
static var this_resource : String = "uid://cmvn68axxmm4"

@onready var sprites: Node2D = %Sprites
@onready var hands: Node2D = %Hands

var animation_counter : int = 0


static func create_this() -> Turret :
	var turret : Turret = (load(this_scene) as PackedScene).instantiate()
	turret.resource = load(this_resource).duplicate()
	turret.update_range()
	return turret


func scan_for_balloons() -> void : 
	var balloon_areas : Array[Area2D] = (%RangeArea as Area2D).get_overlapping_areas()
	var target : BalloonArea2D = null
	var frozen_target : BalloonArea2D = null
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		if target == null or target.get_progress_ratio() < balloon_area.get_progress_ratio() : 
			if not balloon_area.balloon.frozen : 
				target = balloon_area
			else : 
				frozen_target = balloon_area
	
	if target : 
		fire(target.balloon)
		resource.cooldown_progress = resource.cooldown
	elif frozen_target : 
		fire(frozen_target.balloon)
		resource.cooldown_progress = resource.cooldown


func fire(target : Balloon) -> void :
	var direction : Vector2 = (target.global_position - global_position).normalized()
	add_child(Bullet.create(direction, resource.turret_range + 10.0 , 0, 1750.0))
	sprites.rotation = direction.angle()
	fire_animation()


func fire_animation() -> void : 
	var hand : Sprite2D = hands.get_child(animation_counter)
	
	var tween : Tween = create_tween()
	tween.tween_property(hand, "position:x", 24.0, 0.1).from(0.0)
	tween.tween_property(hand, "position:x", 0.0, 0.1)
	
	animation_counter += 1
	if animation_counter == 4 : animation_counter = 0


func get_first_upgrade() -> RUpgrade : 
	return RUpgrade.upgrades[RUpgrade.List.SUPERMONKEY_RANGE]


func apply_first_upgrade() -> void : 
	super()
	resource.turret_range += 100.0
	update_range()


func get_second_upgrade() -> RUpgrade: 
	return RUpgrade.upgrades[RUpgrade.List.SUPERMONKEY_RANGE]


func apply_second_upgrade() -> void : 
	super()
