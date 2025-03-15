class_name MissileParticle extends GPUParticles2D


var get_pooled_callable : Callable


func _ready() -> void :
	(%Timer as Timer).timeout.connect(get_pooled)


func reset(new_position : Vector2 = Vector2.ZERO) -> void : 
	(%Timer as Timer).stop()
	position = new_position
	emitting = true
	restart()
	(%Timer as Timer).start()


func get_pooled() -> void : 
	get_pooled_callable.call(self)
