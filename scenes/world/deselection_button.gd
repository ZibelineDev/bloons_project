extends Button


func _ready() -> void :
	pressed.connect(on_pressed)


func on_pressed() -> void : 
	Turret.deselect_current_turret()
