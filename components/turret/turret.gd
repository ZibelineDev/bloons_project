class_name Turret extends CharacterBody2D


enum Types {
	DART,
	TACK,
	FREEZE,
	BOMB,
	HYPERSONIC,
}


static var turrets : Dictionary[Turret.Types, RTurret] = {
	Turret.Types.DART : load("uid://dtsegxyhlj16x"),
	Turret.Types.TACK : load("uid://bs5qk4acwxdp4")
}


static var scene : String = "uid://dv7ks0wr8gaga"
static var selected_turret : Turret = null


var ghosted : bool = true
var selected : bool = false

var resource : RTurret 

@onready var range_indicator: Sprite2D = %RangeIndicator


func _ready() -> void :
	ghosted = true
	selected = false
	range_indicator.visible = true
	(%TurretCollision as CollisionShape2D).disabled = true
	(%Button as Button).pressed.connect(on_pressed)


func _input(event : InputEvent) -> void :
	if selected_turret and event.is_action_pressed("cancel") : deselect()


func _physics_process(delta : float) -> void :
	if ghosted : return 
	
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


static func create_ghost(type : Types) -> Turret : 
	match type : 
		Types.TACK : return TackTurret.create_this()
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
	(%TurretCollision as CollisionShape2D).disabled = false
	(%BodyArea as Area2D).monitoring = false
	move_and_slide()


func scan_for_balloons() -> void : 
	var balloon_areas : Array[Area2D] = (%RangeArea as Area2D).get_overlapping_areas()
	var target : BalloonArea2D = null
	
	for balloon_area : BalloonArea2D in balloon_areas : 
		print("Scanning a Balloon")
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


func apply_first_upgrade() -> void : 
	pass


func get_second_upgrade() -> RUpgrade : 
	return null


func try_to_purchase_second_upgrade() -> void : 
	pass
