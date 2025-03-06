class_name UserInterface extends HBoxContainer

static var ref : UserInterface

func _init() -> void : 
	ref = self


@warning_ignore("unused_signal")
signal create_turret_pressed(type : Turret.Types)


@onready var feedback_label : RichTextLabel = %FeedbackLabel
@onready var feedback_container : MarginContainer = %FeedbackPanel


func _ready() -> void :
	feedback_container.visible = false


func create_feedback(text : String) -> void : 
	feedback_label.text = text
	feedback_container.visible = true
	await get_tree().create_timer(5.0).timeout
	feedback_container.visible = false
