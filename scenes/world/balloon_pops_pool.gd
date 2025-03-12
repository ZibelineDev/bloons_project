class_name BalloonPopsPool extends Node2D

static var ref : BalloonPopsPool

func _init() -> void :
	ref = self


@onready var balloon_pops: Node2D = %BalloonPops


func _ready() -> void :
	for child : BalloonPop in get_children() : 
		child.action = balloon_pop_tween_finished


func trigger_balloon_pop(new_position : Vector2 = Vector2(0.0, 0.0)) -> void : 
	if get_child_count() == 0 : return
	
	var node : BalloonPop = get_child(0)
	node.reparent(balloon_pops)
	node.reset(new_position)


func balloon_pop_tween_finished(node : BalloonPop) -> void : 
	node.reparent(self)
