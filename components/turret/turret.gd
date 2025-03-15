class_name Turret extends CharacterBody2D


enum Types {
	DART,
	TACK,
	FROZEN,
	BOMB,
	HYPERSONIC,
}


static var turrets : Dictionary[Turret.Types, RTurret] = {
	Types.DART : load("uid://dtsegxyhlj16x"),
	Types.TACK : load("uid://bs5qk4acwxdp4"),
	Types.FROZEN : load("uid://bah20vq8ns2mr"),
	Types.BOMB : load("uid://dh3y4o2qayf4v"),
	Types.HYPERSONIC : load("uid://cmvn68axxmm4"),
}


static var scene : String = "uid://dv7ks0wr8gaga"
static var selected_turret : Turret = null


var ghosted : bool = true
var selected : bool = false

var resource : RTurret 
var value : int

@onready var range_indicator: TurretRangeIndicator = %RangeIndicator


func _ready() -> void :
	value = resource.cost
	ghosted = true
	selected = false
	range_indicator.visible = true
	(%TurretCollision as CollisionShape2D).disabled = true
	(%Button as Button).pressed.connect(on_pressed)


func _input(event : InputEvent) -> void :
	if selected_turret and event.is_action_pressed("cancel") : selected_turret.deselect()


func _physics_process(delta : float) -> void :
	if ghosted :
		if is_colliding() : 
			range_indicator.modulate = Color.RED
			range_indicator.play_tween()
		else : 
			range_indicator.modulate = Color.GREEN
			range_indicator.stop_tween()
	
	else : 
		if resource.cooldown_progress <= 0.0 : 
			scan_for_balloons()
		
		else : 
			resource.cooldown_progress -= delta


func on_pressed() -> void : 
	if ghosted : return 
	select()


func select() -> void : 
	if selected_turret != self :
		if selected_turret != null : 
			selected_turret.deselect()
	selected_turret = self
	TurretInfo.ref.select(self)
	range_indicator.visible = true


func deselect() -> void : 
	range_indicator.visible = false
	selected_turret = null
	TurretInfo.ref.deselect()


static func deselect_current_turret() -> void : 
	if selected_turret : selected_turret.deselect()


static func create_ghost(type : Types) -> Turret : 
	match type : 
		Types.TACK : return TackTurret.create_this()
		Types.FROZEN : return FrozenTurret.create_this()
		Types.HYPERSONIC : return SuperMonkeyTurret.create_this()
		Types.BOMB : return BombTurret.create_this() 
		_, Types.DART : return DartTurret.create_this()


static func create_this() -> Turret : 
	var turret : Turret = (load(scene) as PackedScene).instantiate()
	turret.resource = preload("uid://dtsegxyhlj16x")
	turret.update_range()
	return turret


func update_range() -> void : 
	((%RangeAreaCollision as CollisionShape2D).shape as CircleShape2D).radius = resource.turret_range
	# 256 x X = radius x 2
	var sprite_scale_factor : float = resource.turret_range * 2.0 / 256.0
	(%RangeIndicator as Sprite2D).scale = Vector2(sprite_scale_factor, sprite_scale_factor)
	


func is_colliding() -> bool : 
	if (%BodyArea as Area2D).get_overlapping_bodies().size() > 0 :
		return true
	return false


func place() -> void : 
	ghosted = false
	range_indicator.visible = false
	range_indicator.modulate = Color.WHITE
	(%TurretCollision as CollisionShape2D).disabled = false
	(%BodyArea as Area2D).monitoring = false
	move_and_slide()
	(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)


func scan_for_balloons() -> void : 
	var balloon_areas : Array[Area2D] = (%RangeArea as Area2D).get_overlapping_areas()
	var target : BalloonArea2D = null
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		if target == null or target.get_progress_ratio() < balloon_area.get_progress_ratio() : 
			target = balloon_area
	
	if target : 
		fire(target.balloon)
		resource.cooldown_progress = resource.cooldown


func fire(_target : Balloon) -> void : 
	pass


func get_first_upgrade() -> RUpgrade : 
	return null


func try_to_purchase_first_upgrade() -> void : 
	if resource.first_upgrade_purchased : return
	
	if not (Currency as ACurrency).consume_currency(get_first_upgrade().cost) :
		resource.first_upgrade_purchased = true
		apply_first_upgrade()
		UserInterface.ref.upgrade_purchased.emit()
		(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)


func apply_first_upgrade() -> void : 
	value += get_first_upgrade().cost


func get_second_upgrade() -> RUpgrade : 
	return null


func try_to_purchase_second_upgrade() -> void : 
	if resource.second_upgrade_purchased : return
	
	if not (Currency as ACurrency).consume_currency(get_second_upgrade().cost) :
		resource.second_upgrade_purchased = true
		apply_second_upgrade()
		UserInterface.ref.upgrade_purchased.emit()
		(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)


func apply_second_upgrade() -> void : 
	value += get_second_upgrade().cost


func sell() -> void : 
	(Currency as ACurrency).refund_currency(int(value * 0.66))
	deselect_current_turret()
	queue_free()
	(Sounds as ASounds).play_ui_sound(ASounds.UISounds.CLICK)
