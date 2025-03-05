class_name Turret extends CharacterBody2D


static var scene : String = "uid://dv7ks0wr8gaga"
static var selected_turret : Turret = null


var ghosted : bool = true
var selected : bool = false

var cooldown : float = 0.5
var cooldown_progress : float = 0.0

@onready var range_indicator: Sprite2D = %RangeIndicator


func _ready() -> void :
	ghosted = true
	selected = false
	range_indicator.visible = true
	(%TurretCollision as CollisionShape2D).disabled = true
	(%Button as Button).pressed.connect(on_pressed)


func _physics_process(delta : float) -> void :
	if ghosted : return 
	
	if cooldown_progress <= 0.0 : 
		scan_for_balloons()
	
	else : 
		cooldown_progress -= delta


func on_pressed() -> void : 
	if ghosted : return 
	select()


func select() -> void : 
	if selected_turret != self :
		if selected_turret != null : 
			selected_turret.deselect()
	selected_turret = self
	range_indicator.visible = true


func deselect() -> void : 
	range_indicator.visible = false
	selected_turret = null


static func create_ghost() -> Turret : 
	var turret : Turret = (load(scene) as PackedScene).instantiate()
	return turret


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
		target.hit()
		cooldown_progress = cooldown
