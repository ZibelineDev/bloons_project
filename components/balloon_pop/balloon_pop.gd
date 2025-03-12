class_name BalloonPop extends Sprite2D


var tween : Tween 
var action : Callable


func _ready() -> void :
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.05)
	tween.tween_property(self, "modulate:a", 0.0, 0.15)
	tween.finished.connect(on_tween_finished)
	tween.stop()


func reset(new_position : Vector2 = Vector2(0.0, 0.0)) -> void : 
	scale = Vector2(0.0, 0.0)
	modulate.a = 1.0
	position = new_position
	tween.play()


func on_tween_finished() -> void : 
	tween.stop()
	action.call(self)
