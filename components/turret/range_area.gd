class_name TurretRangeArea extends Area2D


var cooldown : float = 0.5
var cooldown_progress : float = 0.0





func scan_for_balloons() -> void : 
	var balloon_bodies : Array[Node2D] = get_overlapping_bodies()
	var target : BalloonBody = null
	
	for balloon_body : BalloonBody in balloon_bodies : 
		print("Scanning a Balloon")
		if target == null or target.get_progress_ratio() < balloon_body.get_progress_ratio() : 
			target = balloon_body
	
	if target : 
		target.hit()
		cooldown_progress = cooldown
