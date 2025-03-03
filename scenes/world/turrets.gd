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


func create_ghost_turret() -> void :
	if ghost_turret : return
	ghost_turret = Turret.create_ghost()
	add_child(ghost_turret)


func try_to_place() -> void : 
	if ghost_turret.is_colliding() : return
	ghost_turret.place()
	ghost_turret = null


func refund_turret() -> void : 
	ghost_turret.queue_free()
	ghost_turret = null
	(Currency as ACurrency).create_currency(10)


func try_to_purchase() -> void : 
	if not (Currency as ACurrency).consume_currency(10) : 
		create_ghost_turret()


func on_create_turret_pressed() -> void : 
	try_to_purchase()
