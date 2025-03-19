class_name SSSConfirmationPanel extends Panel


@onready var body: Label = %Body
@onready var confirm: Button = %Confirm
@onready var cancel: Button = %Cancel
@onready var check_box: SSSCheckBox = %CheckBox


func _ready() -> void :
	visible = false
	initialise_text()
	confirm.pressed.connect(on_confirm_pressed)
	cancel.pressed.connect(on_cancel_pressed)


func initialise_text() -> void : 
	if (SSS as ASSS).activated : 
		body.text = "You're about to turn off the Super Secret Setting. This will Restart the game. Are your sure ?"
	else : 
		body.text = "You're about to turn on the Super Secret Setting. This will Restart the game. Are your sure ?"


func on_confirm_pressed() -> void : 
	SSS.toggle()


func on_cancel_pressed() -> void : 
	if not SSS.activated : 
		visible = false
		check_box.uncheck()
	else : 
		visible = false
		check_box.check()
