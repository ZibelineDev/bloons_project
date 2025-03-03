class_name UserInterface extends MarginContainer


static var ref : UserInterface


func _init() -> void : 
	ref = self


signal create_turret_pressed


func _ready() -> void :
	(%CreateTurret as Button).pressed.connect(on_create_turret_button_pressed)


func on_create_turret_button_pressed() -> void : 
	create_turret_pressed.emit()
