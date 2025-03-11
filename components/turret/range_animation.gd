extends AnimationPlayer


func _ready() -> void :
	if (SpeedScale as ASpeedScale).is_bending_time() :
		speed_scale = 0.25
	else : 
		speed_scale = 1.0
		
	(SpeedScale as ASpeedScale).began_bending_time.connect(
		func() -> void : 
			speed_scale = 0.25
	)
	(SpeedScale as ASpeedScale).stopped_bending_time.connect(
		func() -> void : 
			speed_scale = 1.0
	)
