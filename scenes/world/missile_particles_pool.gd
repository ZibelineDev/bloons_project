class_name MissileParticlesPool extends Node2D

static var ref : MissileParticlesPool

func _init() -> void : ref = self


@onready var missile_particles: Node2D = %MissileParticles


func _ready() -> void :
	for child : MissileParticle in get_children() : 
		child.get_pooled_callable = get_pooled


func trigger(new_position : Vector2 = Vector2.ZERO) -> void : 
	if get_child_count() == 0 : return
	
	var node : MissileParticle = get_child(0)
	node.reparent(missile_particles)
	node.reset(new_position)


func get_pooled(node : MissileParticle) -> void : 
	node.reparent(self)
