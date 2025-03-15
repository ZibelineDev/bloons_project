class_name EscapeMenu extends Panel


static var is_open : bool = false 


func _ready() -> void :
	visible = false
	is_open = false


func _input(event : InputEvent) -> void :
	if event.is_action_pressed("cancel") : 
		if Turrets2D.ref.ghost_turret : return
		if Turret.selected_turret : return
		
		toggle_menu()


func toggle_menu() -> void : 
	if visible : close_menu()
	else : open_menu()
	(Sounds as ASounds).play_ui_sound(ASounds.UISounds.BONG)


func open_menu() -> void : 
	visible = true
	is_open = true
	(SpeedScale as ASpeedScale).toggle_pause(true)


func close_menu() -> void :
	visible = false
	is_open = false
	(SpeedScale as ASpeedScale).toggle_pause(false)
	
