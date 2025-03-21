class_name UserInterface extends Control

static var ref : UserInterface

func _init() -> void : 
	ref = self


@warning_ignore("unused_signal")
signal create_turret_pressed(type : Turret.Types)
@warning_ignore("unused_signal")
signal upgrade_purchased


@onready var feedback_label : RichTextLabel = %FeedbackLabel
@onready var feedback_container : MarginContainer = %FeedbackPanel


func _ready() -> void :
	feedback_container.visible = false


func create_feedback(text : String) -> void : 
	feedback_label.text = text
	feedback_container.visible = true
	await get_tree().create_timer(get_feedback_time()).timeout
	feedback_container.visible = false


func get_feedback_time() -> float : 
	if (SpeedScale as ASpeedScale).is_bending_time() : 
		return 40.0
	else : 
		return 10.0
