class_name UserInterface extends HBoxContainer

static var ref : UserInterface

func _init() -> void : 
	ref = self


signal create_turret_pressed


@onready var feedback_label : RichTextLabel = %FeedbackLabel
@onready var feedback_container : MarginContainer = %FeedbackPanel


func _ready() -> void :
	(%CreateTurret as Button).pressed.connect(on_create_turret_button_pressed)
	feedback_container.visible = false


func create_feedback(text : String) -> void : 
	feedback_label.text = text
	feedback_container.visible = true
	await get_tree().create_timer(5.0).timeout
	feedback_container.visible = false


func on_create_turret_button_pressed() -> void : 
	create_turret_pressed.emit()
