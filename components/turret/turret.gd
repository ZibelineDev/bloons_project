class_name Turret extends CharacterBody2D


static var scene : String = "uid://dv7ks0wr8gaga"


var ghosted : bool = true

var cooldown : float = 0.5
var cooldown_progress : float = 0.0


func _ready() -> void :
	ghosted = true
	(%TurretCollision as CollisionShape2D).disabled = true


func _physics_process(delta : float) -> void :
	if ghosted : return 
	
	if cooldown_progress <= 0.0 : 
		scan_for_balloons()
	
	else : 
		cooldown_progress -= delta


static func create_ghost() -> Turret : 
	var turret : Turret = (load(scene) as PackedScene).instantiate()
	return turret


func is_colliding() -> bool : 
	if (%BodyArea as Area2D).get_overlapping_bodies().size() > 0 :
		return true
	return false


func place() -> void : 
	ghosted = false
	(%TurretCollision as CollisionShape2D).disabled = false
	(%BodyArea as Area2D).monitoring = false
	move_and_slide()


func scan_for_balloons() -> void : 
	var balloon_bodies : Array[Node2D] = (%RangeArea as Area2D).get_overlapping_bodies()
	var target : BalloonBody = null
	
	for balloon_body : BalloonBody in balloon_bodies : 
		print("Scanning a Balloon")
		if target == null or target.get_progress_ratio() < balloon_body.get_progress_ratio() : 
			target = balloon_body
	
	if target : 
		target.hit()
		cooldown_progress = cooldown
