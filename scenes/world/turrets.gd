class_name Turrets2D extends Node2D


var ghost_turret : Turret = null


func _ready() -> void :
	UserInterface.ref.create_turret_pressed.connect(on_create_turret_pressed)


func _input(event : InputEvent) -> void :
	if not ghost_turret : return
	
	if event is InputEventMouse :
		ghost_turret.position = (event as InputEventMouse).position
	
	if event.is_action_pressed("left_click") :
		try_to_place()
	
	if event.is_action_pressed("cancel") : 
		refund_turret()


func create_ghost_turret(type : Turret.Types) -> void :
	if ghost_turret : return
	ghost_turret = Turret.create_ghost(type)
	add_child(ghost_turret)


func try_to_place() -> void : 
	if ghost_turret.is_colliding() : return
	ghost_turret.place()
	ghost_turret = null


func refund_turret() -> void : 
	(Currency as ACurrency).create_currency(ghost_turret.resource.cost)
	ghost_turret.queue_free()
	ghost_turret = null


func try_to_purchase(type : Turret.Types) -> void : 
	if ghost_turret : return
	if not (Currency as ACurrency).consume_currency(Turret.turrets[type].cost) : 
		create_ghost_turret(type)


func on_create_turret_pressed(type : Turret.Types) -> void : 
	try_to_purchase(type)
