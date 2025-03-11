class_name TurretRangeIndicator extends Sprite2D


var initial_scale : Vector2 

var colliding_tween : Tween


func _ready() -> void :
	initial_scale = scale
	
	colliding_tween = create_tween()
	colliding_tween.set_loops()
	colliding_tween.tween_property(self, "scale", initial_scale - Vector2(0.1, 0.1), get_duration())
	colliding_tween.tween_property(self, "scale", initial_scale, get_duration())
	colliding_tween.stop()


func play_tween() -> void : 
	colliding_tween.play()


func get_duration() -> float : 
	if (SpeedScale as ASpeedScale).is_bending_time() : 
		return 0.15 * 4.0
	else :
		return 0.15


func stop_tween() -> void : 
	colliding_tween.stop()
	scale = initial_scale
