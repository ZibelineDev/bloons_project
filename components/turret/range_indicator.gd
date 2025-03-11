class_name TurretRangeIndicator extends Sprite2D


var initial_scale : Vector2 

var colliding_tween : Tween


func _ready() -> void :
	initial_scale = scale
	
	colliding_tween = create_tween()
	colliding_tween.set_loops()
	colliding_tween.tween_property(self, "scale", initial_scale - Vector2(0.1, 0.1), 0.15)
	colliding_tween.tween_property(self, "scale", initial_scale, 0.15)
	colliding_tween.stop()


func play_tween() -> void : 
	colliding_tween.play()


func stop_tween() -> void : 
	colliding_tween.stop()
	scale = initial_scale
